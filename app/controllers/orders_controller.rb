class OrdersController < ApplicationController
  before_action :check_access_customer, only: [:index_customers, :show_customers, :new, :pay]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_restaurants, only: [:index_restaurants, :show_restaurants, :confirmed, :ready]
  before_action :set_order_customers, only: [:show_customers, :pay]
  before_action :set_order_restaurants, only: [:show_restaurants, :confirmed, :ready]

  # GET /orders
  # GET /orders.json
  def index
    #@orders = Order.all
    if (current_user.role.downcase == "customer")
      redirect_to "/customers/order"
    elsif current_user.role == 'shipper'
        @orders = Order.includes(:restaurant).where(assigned: false).where.not(confirmed_at: nil)
    end
  end

  def index_customers
    if params[:filter] == "ongoing"
      @orders = Order.select("orders.*, restaurants.name AS rest_name")
                          .where(:user_id => current_user.id,
                            :arrived_at => nil
                          ).joins("LEFT JOIN restaurants ON restaurants.id = orders.restaurant_id")
    else
      @orders = Order.select("orders.*, restaurants.name AS rest_name")
                          .where(:user_id => current_user.id
                          ).joins("LEFT JOIN restaurants ON restaurants.id = orders.restaurant_id")
    end
  end

  def index_restaurants
    if params[:filter] == "pending-confirmed"
      @orders = Order.select("orders.*, customers.name AS user_name")
                          .where(:restaurant_id => @current_restaurant.id,
                            :confirmed_at => nil,
                            :paid => true
                          )
                          .joins("LEFT JOIN customers ON customers.user_id = orders.user_id")
    elsif params[:filter] == "preparing"
      @orders = Order.select("orders.*, customers.name AS user_name")
                          .where(:restaurant_id => @current_restaurant.id,
                            :ready => false,
                            :paid => true
                          )
                          .where.not(:confirmed_at => nil)
                          .joins("LEFT JOIN customers ON customers.user_id = orders.user_id")
    else
      @orders = Order.select("orders.*, customers.name AS user_name")
                          .where(:restaurant_id => @current_restaurant.id,
                            :paid => true
                          )
                          .joins("LEFT JOIN customers ON customers.user_id = orders.user_id")
    end
  end

  def show_customers
    # @food = Food.where(:id => @order.food_id)
    @restaurant = Restaurant.find(@order.restaurant_id)
    @food_list = ActiveSupport::JSON.decode(@order.food_json)
    @food_list.each do |item|
      item["name"] = Food.find(item["id"]).name
    end
  end

  def show_restaurants
    @restaurant = Restaurant.find(@order.restaurant_id)
    @food_list = ActiveSupport::JSON.decode(@order.food_json)
    @food_list.each do |item|
      item["name"] = Food.find(item["id"]).name
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    if current_user.role.downcase == "customer"
      redirect_to "/customers/order/#{params[:id]}"
    end
  end

  # GET /orders/new
  def new
    if session[:cart] == nil or session[:cart] == ""
      session[:cart] = ActiveSupport::JSON.encode({})
    end
    
    @cart = ActiveSupport::JSON.decode(session[:cart])
    @restaurant = nil

    @cart.each do |item|
      item["food"] = Food.find(item["food_id"])

      if @restaurant == nil
        @restaurant = Restaurant.find(item["food"].restaurant_id)
      end
    end

    if @restaurant == nil
      render html: "Empty Purchase Cart".html_safe and return
    end
    
    @customer = Customer.find_by(user_id: current_user.id)
    @order = Order.new
  end

  def addtocart
    @customer = Customer.find_by(user_id: current_user.id)
    @food = Food.find(params[:id])

    if session[:cart] == nil or session[:cart] == ""
      session[:cart] = ActiveSupport::JSON.encode(Array.new())
    end

    cart = ActiveSupport::JSON.decode(session[:cart])
    
    isFound = false
    cart.each do |item|
      if item["food_id"] == params[:id]
        isFound = true
        break
      end
    end

    if not isFound
      cart.push({food_id: params[:id], count: 1})
    end

    session[:cart] = ActiveSupport::JSON.encode(cart)

    redirect_to '/orders/new'
  end

  def pay
    @order.update(paid: 1)

    render html: "<script>\nalert('Successfully pay the order.');\nwindow.location = '/customers/order';\n</script>".html_safe and return;
  end

  def confirmed
    @order.update(confirmed_at: DateTime.now)

    render html: "<script>\nalert('Successfully confirmed the order. Please prepare food.');\nwindow.location = '/restaurants/order';\n</script>".html_safe and return;
  end

  def ready
    @order.update(ready: 1)

    render html: "<script>\nalert('Order is marked as ready.');\nwindow.location = '/restaurants/order';\n</script>".html_safe and return;
  end

  def take
    unless current_user.role == 'shipper'
      render :file => 'public/404.html', :status => :not_found, :layout => false and return
    end

    @order = Order.find(params[:id])
    @order.assigned = true
    @order.shipper_id = Shipper.find_by_user_id(current_user.id).id
    if @order.save
      flash[:notice] = 'Order taken!'
    else
      flash[:notice] = 'Failed to take the order!'
    end
    redirect_to orders_path
  end

  # GET /orders/1/edit
  #def edit
  #end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    if session[:cart] == nil and session[:cart] == ""
      render html: "Empty Purchase Cart".html_safe and return
    end

    @order.price = 0
    @food = nil
    cart = ActiveSupport::JSON.decode(session[:cart])
    count = 0
    food_json = Array.new()

    cart.each do |item|
      food = Food.find(item["food_id"])
      @order.price += food.price * params["food_count_" + item["food_id"]].to_i

      if params["food_count_" + item["food_id"]].to_i > 0
        tmp_count = params["food_count_" + item["food_id"]].to_i
        count = count + tmp_count
        food_json.push({id: item["food_id"], count: tmp_count, price: food.price * tmp_count})
      end

      if @food == nil
        @food = Food.find(item["food_id"])
      end
    end

    if @food == nil or count == 0
      render html: "Empty Purchase Cart".html_safe and return
    end

    @order.food_json = ActiveSupport::JSON.encode(food_json)
    @order.user_id = current_user.id
    @order.restaurant_id = @food.restaurant_id
    @order.paid = 0
    @order.ready = 0
    @order.assigned = 0
    @order.arrived = 0

    respond_to do |format|
      if @order.save
        session[:cart] = ""

        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def set_order_customers
      @order = Order.find(params[:id])

      if @order.user_id != current_user.id
        render html: "Access denied. Not your order.".html_safe and return
      end
    end

    def set_restaurants
      if current_user.role.downcase != 'restaurant'
        render html: "Access denied.".html_safe and return
      end

      @current_restaurant = Restaurant.find_by(user_id: current_user.id)
    end

    def set_order_restaurants
      @order = Order.find(params[:id])
                    #.where("orders.*, customers.name AS user_name")
                    #.joins("LEFT JOIN customers ON customers.user_id = orders.user_id")

      if @order.restaurant_id != @current_restaurant.id
        render html: "Access denied. Not your order.".html_safe and return
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      #params.require(:order).permit(:price, :paid, :ready, :assigned, :arrived, :address, :zip, :phone, :shipped_at, :arrived_at, :confirmed_at, :restaurant_id, :customer_id)
      params.require(:order).permit(:address, :zip, :phone)
    end

    def check_access_customer
      if current_user.role.downcase != "customer"
        render html: "Access denied.".html_safe and return
      end
    end
end
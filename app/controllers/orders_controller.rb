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
    end
    render html: ""
  end

  def index_customers
    if params[:filter] == "ongoing"
      @orders = Order.select("orders.*, restaurants.name AS rest_name, foods.name AS food_name")
                          .where(:user_id => current_user.id,
                            :arrived_at => nil
                          ).joins("LEFT JOIN foods ON foods.id = orders.food_id LEFT JOIN restaurants ON restaurants.id = orders.restaurant_id")
    else
      @orders = Order.select("orders.*, restaurants.name AS rest_name, foods.name AS food_name")
                          .where(:user_id => current_user.id
                          ).joins("LEFT JOIN foods ON foods.id = orders.food_id LEFT JOIN restaurants ON restaurants.id = orders.restaurant_id")
    end
  end

  def index_restaurants
    if params[:filter] == "pending-confirmed"
      @orders = Order.select("orders.*, foods.name AS food_name")
                          .where(:restaurant_id => @current_restaurant.id,
                            :confirmed_at => nil
                          )
                          .joins("LEFT JOIN foods ON foods.id = orders.food_id")
    elsif params[:filter] == "preparing"
      @orders = Order.select("orders.*, foods.name AS food_name")
                          .where(:restaurant_id => @current_restaurant.id,
                            :ready => false
                          )
                          .where.not(:confirmed_at => nil)
                          .joins("LEFT JOIN foods ON foods.id = orders.food_id")
    else
      @orders = Order.select("orders.*, foods.name AS food_name")
                          .where(:restaurant_id => @current_restaurant.id)
                          .joins("LEFT JOIN foods ON foods.id = orders.food_id")
    end
  end

  def show_customers
    # @food = Food.where(:id => @order.food_id)
    @restaurant = Restaurant.find(@order.restaurant_id)
    @food = Food.find(@order.food_id)
  end

  def show_restaurants
    @restaurant = Restaurant.find(@order.restaurant_id)
    @food = Food.find(@order.food_id)
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
    @customer = Customer.find_by(user_id: current_user.id)
    @food = Food.find(params[:id])
    @restaurant = Restaurant.find(@food.restaurant_id)
    @order = Order.new
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

  # GET /orders/1/edit
  #def edit
  #end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @food = Food.find(params[:food_id])
    @order.food_id = params[:food_id]
    @order.user_id = current_user.id
    @order.price = @food.price
    @order.restaurant_id = @food.restaurant_id
    @order.paid = 0
    @order.ready = 0
    @order.assigned = 0
    @order.arrived = 0

    respond_to do |format|
      if @order.save
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

      if @order.restaurant_id != @current_restaurant.id
        render html: "Access denied. Not your order.".html_safe and return
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      #params.require(:order).permit(:price, :paid, :ready, :assigned, :arrived, :address, :zip, :phone, :shipped_at, :arrived_at, :confirmed_at, :restaurant_id, :customer_id)
      params.require(:order).permit(:food_id, :address, :zip, :phone)
    end

    def check_access_customer
      if current_user.role.downcase != "customer"
        render html: "Access denied.".html_safe and return
      end
    end
end

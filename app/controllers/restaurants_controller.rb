class RestaurantsController < ApplicationController
  before_action :check_access, except: [:show, :index]
  before_action :set_restaurant, only: [:create_food,:show,:edit, :update, :destroy]

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
    @restaurants.each do |item|
      if item.avg_rating < 0
        rating = Comment.select("AVG(rating) AS rating")
                              .where(:restaurant_id => item.id)
                              .first.rating
        if rating == nil
          rating = 0.0
        end

        item.update(avg_rating: rating)
      end
    end

    if current_user.role.downcase == 'customer'
      @address = Customer.select(:address).find_by user_id: current_user.id
    else
      @address = Restaurant.select(:address).find_by user_id: current_user.id
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    @restaurant = Restaurant.find(params[:id])
    @foods = Food.where(:restaurant_id => @restaurant.id) #@restaurant.foods
    @comments = Comment.where(:restaurant_id => @restaurant.id) #@restaurant.comments
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to '/restaurants/setting?feedback=succ' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find_by(user_id: current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :zip, :phone, :user_id)
    end

  private
    def check_access
      if current_user.role.downcase != "restaurant"
        render html: "Access denied.".html_safe and return
      end
    end
    
end

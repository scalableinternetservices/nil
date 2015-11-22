class FoodsController < ApplicationController
  #before_action :check_restid, only: [:new, :edit, :update, :destroy]

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    if current_user.role.downcase == "restaurant" and @restaurant.user_id == current_user.id
      redirect_to "/restaurants/menu"
    else
      @foods = @restaurant.foods
    end
  end

  def index_restaurants
    @restaurant = Restaurant.find_by user_id: current_user.id
    @foods = @restaurant.foods
  end
  def new
    @food = Food.new
    @restaurant = Restaurant.find_by user_id: current_user.id
  end
  
  def create
      @restaurant = Restaurant.find_by user_id: current_user.id
      @food = @restaurant.foods.create(food_params)
      upload
      if @food.save
        # flash[:success] = "Successfully add your new food!"
        redirect_to restaurant_food_path(@restaurant, @food)
      else
        render :new
      end
  end
  
  def show
    @food = Food.find(params[:id])
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def edit
    @restaurant = Restaurant.find_by user_id: current_user.id
    @food = @restaurant.foods.find(params[:id])
  end
  
  def update
    @restaurant = Restaurant.find_by user_id: current_user.id
    @food = @restaurant.foods.find(params[:id])
    upload
    if @food.update(food_params)
      redirect_to restaurants_menu_path()
    else
      render :edit
    end
  end
  
  def destroy
      @restaurant = Restaurant.find_by user_id: current_user.id
      @food = @restaurant.foods.find(params[:id])
    if @food.destroy
      redirect_to restaurants_menu_path()
    else
      render @restaurant
    end
      
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_restaurant
    #   @restaurant = Restaurant.find_by(user_id: current_user.id)
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_params
      params.require(:food).permit(:name, :price, :description, :restaurant_id,:num_left)
    end
    
    def upload
        if uploaded_io = params[:food][:image]
          file_name = "#{@restaurant.id}_#{@food.id}.jpg"
          File.open(Rails.root.join('public', 'images', file_name), 'wb') do |file|
              file.write(uploaded_io.read)
          end
          @food.update image: file_name
        elsif !@food.image
          @food.update image: 'default.jpg'
        end
    end

    def check_restid
      @restaurant = Restaurant.find_by user_id: current_user.id
      if @restaurant.id != params[:restaurant_id].to_i
         render html: "Access denied.".html_safe and return
      end
    end
end

class FoodsController < ApplicationController
  before_action  only: [:show,:edit, :update, :destroy]
  
  def index
    #@foods = Food.all
    @restaurant = Restaurant.find_by user_id: current_user.id
    @foods = @restaurant.foods

  end
  
  def new
    @food = Food.new
    @restaurant = Restaurant.find_by user_id: current_user.id

  end
  
  def create
      @restaurant = Restaurant.find_by user_id: current_user.id
      @food = @restaurant.foods.build(food_params)
      if @food.save
        # flash[:success] = "Successfully add your new food!"
        redirect_to restaurant_foods_path(@restaurant)
      else
        render :new
      end
  end
  
  def show
    @food = Food.find(params[:id])
    @restaurant = Restaurant.find_by user_id: current_user.id
  end

  def edit
    @restaurant = Restaurant.find_by user_id: current_user.id
    @food = @restaurant.foods.find(params[:id])
  end
  
  def update
    @restaurant = Restaurant.find_by user_id: current_user.id
    @food = @restaurant.foods.find(params[:id])
    if @food.update(food_params)
      redirect_to restaurant_foods_path(@restaurant)
    else
      render :edit
    end
  end
  
  def destroy
      @restaurant = Restaurant.find_by user_id: current_user.id
      @food = @restaurant.foods.find(params[:id])
    if @food.destroy
      redirect_to restaurant_foods_path(@restaurant)
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
      params.require(:food).permit(:name, :price, :description, :restaurant_id,:image)
    end
    
end

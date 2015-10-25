class FoodsController < ApplicationController
  before_action  only: [:show,:edit, :update, :destroy]
  def index
    @foods = Food.all
    @restaurant = Restaurant.find_by user_id: current_user.id
  end
  
  def new
    @food = Food.new
    
  end
  
  def create
      @food = Food.new(food_params)

      respond_to do |format|
      if @food.save
        format.html { redirect_to @food, notice: 'Food was successfully created.' }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
  end

  def edit
  end
  
  def update
  
  end
  
  def destroy
  
  end
  
    private
    # Use callbacks to share common setup or constraints between actions.
     def set_restaurant
       @restaurant = Restaurant.find_by(user_id: current_user.id)
     end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_params
      params.require(:food).permit(:name, :price, :description, :restaurant_id)
    end
    
end

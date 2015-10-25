class FoodsController < ApplicationController
  before_action :set_food, only: [:show,:edit, :update, :destroy]
  def index
    @foods = Food.all
  end
  
  def new
    @food = Food.new
  end
  
#   def create
#       @food = Food.new(restaurant_params)

#      respond_to do |format|
#       if @food.save
#         format.html { redirect_to @food, notice: 'Food was successfully created.' }
#         format.json { render :show, status: :created, location: @food }
#       else
#         format.html { render :new }
#         format.json { render json: @food.errors, status: :unprocessable_entity }
#       end
#     end
#   end
  
  def show
  end

  def edit
  end
  
  def update
  
  end
  
  def destroy
  
  end
end

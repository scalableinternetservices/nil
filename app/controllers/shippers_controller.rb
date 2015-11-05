class ShippersController < ApplicationController
  before_action :set_shipper, only: [:show, :edit, :update, :destroy, :showOrders]
  before_action :check_access
  

  # GET /shippers
  # GET /shippers.json
  def index
    @shippers = Shipper.all
  end

  # GET /shippers/1
  # GET /shippers/1.json
  def show
  end

  # GET /shippers/new
  def new
    @shipper = Shipper.new
  end

  # GET /shippers/1/edit
  def edit
  end

  # POST /shippers
  # POST /shippers.json
  def create
    @shipper = Shipper.new(shipper_params)

    respond_to do |format|
      if @shipper.save
        format.html { redirect_to @shipper, notice: 'Shipper was successfully created.' }
        format.json { render :show, status: :created, location: @shipper }
      else
        format.html { render :new }
        format.json { render json: @shipper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shippers/1
  # PATCH/PUT /shippers/1.json
  def update
    respond_to do |format|
      if @shipper.update(shipper_params)
        format.html { redirect_to edit_shipper_path(@shipper), notice: 'Shipper was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipper }
      else
        format.html { render :edit }
        format.json { render json: @shipper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shippers/1
  # DELETE /shippers/1.json
  def destroy
    @shipper.destroy
    respond_to do |format|
      format.html { redirect_to shippers_url, notice: 'Shipper was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def showOrders
    @orders = Order.includes(:shipper).where(shippers: {user_id: current_user.id}).includes(:restaurant)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipper
      # @shipper = Shipper.find(params[:id])
      @shipper = Shipper.find_by_user_id current_user.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipper_params
      params.require(:shipper).permit(:name, :address, :zip, :user_id, :phone)
    end

    def check_access
      if current_user.role != 'shipper'
        render html: 'Access denied.'.html_safe and return
      end
    end
end
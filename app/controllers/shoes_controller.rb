class ShoesController < ApplicationController
  before_action :set_shoe, only: [:show, :edit, :update, :destroy]
  before_action :check_if_user_has_organization

  # GET /shoes
  # GET /shoes.json
  def index
    @shoes = Shoe.where(organization_id: current_user.organization.id, delivered: false, void: false).order(created_at: :desc)
    respond_to do |format|
      format.html
      format.js do
        @shoes = helpers.search_results
      end
      format.csv do
        @shoes = helpers.search_results if params[:search_options]
        send_data(@shoes.to_csv, filename: "items-#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}.csv")
      end
    end
  end

  # GET /shoes/1
  # GET /shoes/1.json
  def show
  end

  # GET /shoes/new
  def new
    @shoe = Shoe.new
  end

  # GET /shoes/1/edit
  def edit
  end

  # POST /shoes
  # POST /shoes.json
  def create
    @shoe = Shoe.new(shoe_params)

    respond_to do |format|
      if @shoe.save
        format.html { redirect_to @shoe, notice: 'Shoe was successfully created.' }
        format.json { render :show, status: :created, location: @shoe }
      else
        format.html { render :new }
        format.json { render json: @shoe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shoes/1
  # PATCH/PUT /shoes/1.json
  def update
    respond_to do |format|
      if @shoe.update(shoe_params)
        format.html { redirect_to @shoe, notice: 'Shoe was successfully updated.' }
        format.json { render :show, status: :ok, location: @shoe }
      else
        format.html { render :edit }
        format.json { render json: @shoe.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_shoe
    @shoe = Shoe.find(params[:id])
    raise StandardError.new("Shoe does not belong to user's organization") unless @shoe.organization == current_user.organization
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def shoe_params
    permitted_params = params.require(:shoe).permit(:color, :date_received, :date_due, :owner, :phone, :type_of_payment, :cost, :product_type, :brand, :gender, :task_description, :paid_for, :location, :finished, :delivered, :custom_product_type, :update_date_due, :updated_date_due, :void)
    permitted_params = helpers.setup_delivered_date(@shoe, permitted_params) if action_name == "update"
    permitted_params.merge!(organization_id: current_user.organization.id)
  end
end

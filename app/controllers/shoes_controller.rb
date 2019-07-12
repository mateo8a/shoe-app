class ShoesController < ApplicationController
  before_action :set_shoe, only: [:show, :edit, :update, :destroy]
  before_action :check_if_user_has_organization

  # GET /shoes
  # GET /shoes.json
  def index
    @shoes = Shoe.where(organization_id: current_user.organization.id).order(created_at: :desc)
    respond_to do |format|
      format.html
      format.js do
        # debugger
        set_search_results
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
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def shoe_params
    permitted_params = params.require(:shoe).permit(:color, :date_received, :date_due, :owner, :phone, :type_of_payment, :cost, :product_type, :brand, :gender, :task_description, :paid_for, :location, :finished, :delivered)
    permitted_params.merge(organization_id: current_user.organization.id)
  end

  def check_if_user_has_organization
    if current_user
      render "users/organization_required" unless current_user.organization
    end
  end

  def set_search_results
    search_params = params[:search_options]
    date_received_search(search_params)
    date_due_search(search_params)
  end

  def date_received_search(search_params)
    if param_to_boolean(search_params[:date_received])
      date_received_from = Date.new(search_params["date_received_from(1i)"].to_i, search_params["date_received_from(2i)"].to_i, search_params["date_received_from(3i)"].to_i)
      date_received_to = Date.new(search_params["date_received_to(1i)"].to_i, search_params["date_received_to(2i)"].to_i, search_params["date_received_to(3i)"].to_i)
      @shoes = @shoes.where(date_received: date_received_from..date_received_to)
    end
  end

  def date_due_search(search_params)
    if param_to_boolean(search_params[:date_due])
      date_due_from = Date.new(search_params["date_due_from(1i)"].to_i, search_params["date_due_from(2i)"].to_i, search_params["date_due_from(3i)"].to_i)
      date_due_to = Date.new(search_params["date_due_to(1i)"].to_i, search_params["date_due_to(2i)"].to_i, search_params["date_due_to(3i)"].to_i)
      @shoes = @shoes.where(date_due: date_due_from..date_due_to)
    end
  end
end

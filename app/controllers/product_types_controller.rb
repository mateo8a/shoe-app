class ProductTypesController < ApplicationController
  before_action :set_product_type, only: [:show]
  before_action :check_if_user_has_organization

  def index
    @product_types = current_user.organization.product_types
  end

  def new
    @product_type = ProductType.new
  end

  def show
  end

  def create
    @product_type = ProductType.new(product_type_params)

    respond_to do |format|
      if @product_type.save
        format.html { redirect_to @product_type, notice: 'Product type was successfully created.' }
        format.json { render :show, status: :created, location: @product_type }
      else
        format.html { render :new }
        format.json { render json: @product_type.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product_type
    @product_type = current_user.organization.product_types.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_type_params
    permitted_params = params.require(:product_type).permit(:name, :organization_id)
    permitted_params.merge(organization_id: current_user.organization.id)
  end
end

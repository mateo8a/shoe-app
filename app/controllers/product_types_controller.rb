class ProductTypesController < ApplicationController
  before_action :set_product_type, only: [:show, :edit, :update, :destroy]
  before_action :check_if_user_has_organization
  before_action :require_superuser
  before_action :check_if_product_type_has_items, only: [:edit, :update, :destroy]

  def index
    @product_types = current_user.organization.product_types
  end

  def new
    @product_type = ProductType.new
  end

  def show
  end

  def edit
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

  def update
    respond_to do |format|
      if @product_type.update(product_type_params)
        format.html { redirect_to @product_type, notice: 'Product type was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_type }
      else
        format.html { render :edit }
        format.json { render json: @product_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product_type.destroy
    respond_to do |format|
      format.html { redirect_to product_types_url, notice: 'Product type was successfully destroyed.' }
      format.json { head :no_content }
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

  def check_if_product_type_has_items
    disabled_action = current_user.organization.shoes.any? do |s|
      s.product_type == @product_type.name
    end
    raise StandardError.new("cannot complete request because records exist with this product type") if disabled_action
  end
end

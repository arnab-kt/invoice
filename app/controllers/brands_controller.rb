class BrandsController < ApplicationController

  before_action :find_brand, only: [:show, :edit, :update, :destroy]

  def index
    @brands = Brand.all
    @serial_number = 1
  end

  def show
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      flash[:notice] = "Brand created successfully"
      redirect_to brands_path
    else
      flash.now[:alert] = "Error while creating Brand"
      render "new"
    end
  end

  def edit
  end

  def update
    if @brand.update(brand_params)
      flash[:notice] = "Brand edited successfully"
      redirect_to brands_path
    else
      flash.now[:alert] = "Error while editing Brand"
      render "edit"
    end
  end

  def destroy
  end

  private

  def brand_params
    params.require(:brand).permit(:name, :active)
  end

  def find_brand
    @brand = Brand.find(params[:id])
  end
end

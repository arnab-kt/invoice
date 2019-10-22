class BrandsController < ApplicationController

  before_action :find_brand, only: [:show, :edit, :update]

  def index
    @brands = Brand.all
  end

  def show
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      flash[:success] = "Brand created successfully"
      redirect_to brands_path
    else
      flash.now[:danger] = "Error while creating Brand"
      render "new"
    end
  end

  def edit
  end

  def update
    if @brand.update(brand_params)
      flash[:success] = "Brand edited successfully"
      redirect_to brands_path
    else
      flash.now[:danger] = "Error while editing Brand"
      render "edit"
    end
  end


  private

  def brand_params
    params.require(:brand).permit(:name, :active)
  end

  def find_brand
    @brand = Brand.find(params[:id])
  end
end

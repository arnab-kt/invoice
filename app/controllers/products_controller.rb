class ProductsController < ApplicationController

  before_action :find_product, only: [:edit, :update]
  def index
    @products = Product.includes(:category, :brand, :uom).all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = "Product Added Successfully"
      redirect_to products_path
    else
      flash.now[:danger] = "Error while adding Product"
      render "new"
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash[:success] = "Product Edited Successfully"
      redirect_to products_path
    else
      flash.now[:danger] = "Error while editing Product"
      render "new"
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :active, :brand_id, :category_id, :uom_id)
  end

  def find_product
    @product = Product.find(params[:id])
  end

end

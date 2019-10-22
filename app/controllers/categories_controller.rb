class CategoriesController < ApplicationController

  before_action :find_category, only: [:edit, :update]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "Category created successfully"
      redirect_to categories_path
    else
      flash.now[:danger] = "Error while creating Category"
      render "new"
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Category edited successfully"
      redirect_to categories_path
    else
      flash.now[:danger] = "Error while editing Category"
      render "edit"
    end
  end


  private

  def category_params
    params.require(:category).permit(:name, :active)
  end

  def find_category
    @category = Category.find(params[:id])
  end

end

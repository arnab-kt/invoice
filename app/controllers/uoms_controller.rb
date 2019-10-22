class UomsController < ApplicationController

  before_action :find_uom, only: [:edit, :update]

  def index
    @uoms = Uom.all
  end

  def new
    @uom = Uom.new
  end

  def create
    @uom = Uom.new(uom_params)

    if @uom.save
      flash[:success] = "Unit Of Measurement Added Successfully"
      redirect_to uoms_path
    else
      flash.now[:danger] = "Error while adding Unit Of Measurement"
      render "new"
    end
  end

  def edit
  end

  def update
    if @uom.update(uom_params)
      flash[:success] = "Unit Of Measurement edited Successfully"
      redirect_to uoms_path
    else
      flash.now[:danger] = "Error while editing Unit Of Measurement"
      render "new"
    end
  end

  private

  def uom_params
    params.require(:uom).permit(:name, :abbreviation, :active)
  end

  def find_uom
    @uom = Uom.find(params[:id])
  end
end
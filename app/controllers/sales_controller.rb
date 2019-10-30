class SalesController < ApplicationController
  before_action :find_sale, only: [:show, :edit, :update, :destroy]

  def index
    @sales = Sale.includes(:sale_items).order_by_sale_date
  end

  def show
    @sale_items = @sale.sale_items.includes({ product: [:uom, :brand, :category] })

    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@sale, @sale.sale_items)
        send_data pdf.render, filename: "Invoice #{1000 + @sale.id}", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def new
    @sale = Sale.new
    sale_items = @sale.sale_items.build
  end

  def create
    @sale = Sale.new(sale_params)

    if @sale.sale_items.blank?
      flash.now[:danger] = "Please enter atleast one sale item"
      render "new"
      return
    end

    if @sale.save
      flash[:success] = "Sale data added successfully"
      redirect_to sales_path
    else
      flash.now[:danger] = "Sale failed"
      render "new"
    end
  end

  def edit
  end

  def update
    sale_items_empty_flag = 1
    sale_params[:sale_items_attributes].keys.each do |key|
      if sale_params[:sale_items_attributes][key]["_destroy"] == "false"
        sale_items_empty_flag = 0
      end
    end

    if sale_items_empty_flag == 1
      flash.now[:danger] = "Please keep atleast one sale item"
      render "edit"
      return
    end

    if @sale.update_attributes(sale_params)
      flash[:success] = "Sale edited Successfully"
      redirect_to sales_path
    else
      flash.now[:danger] = "Error while editing sale"
      render "edit"
    end
  end

  def destroy
    @sale.destroy
    flash[:success] = "Sale Data Successfully Deleted"
    redirect_to sales_path
  end

  private

  def sale_params
    params.require(:sale).permit(:date, sale_items_attributes: [:id, :product_id, :quantity, :rate, :_destroy])
  end

  def find_sale
    @sale = Sale.find(params[:id])
  end
end

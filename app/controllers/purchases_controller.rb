class PurchasesController < ApplicationController

  before_action :find_purchase, only: [:show, :edit, :update, :destroy]

  def index
    @purchases = Purchase.includes(:purchase_items).order_by_purchase_date
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@purchase)
        send_data pdf.render, filename: "Invoice #{1000000000+@purchase.id}", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def new
    @purchase = Purchase.new
    #purchase_items = @purchase.purchase_items.build
  end

  def create
    @purchase = Purchase.new(purchase_params)

    if @purchase.save
      flash[:success] = "Purchase data added successfully"
      redirect_to purchases_path
    else
      flash.now[:danger] = "Purchase failed"
      render "new"
    end
  end

  def edit
  end

  def update
    if @purchase.update_attributes(purchase_params)
      flash[:success] = "Purchase edited Successfully"
      redirect_to purchases_path
    else
      flash.now[:danger] = "Error while editing purchase"
      render "edit"
    end
  end

  def destroy
    @purchase.destroy
    flash[:success] = "Purchase Data Successfully Deleted"
    redirect_to purchases_path
  end

  private

  def purchase_params
    params.require(:purchase).permit(:date, purchase_items_attributes: [:id, :product_id, :quantity, :rate, :_destroy])
  end

  def find_purchase
    @purchase = Purchase.find(params[:id])
  end
end

require 'prawn'
class InvoicePdf < Prawn::Document

  def initialize(invoice)
    super(top_margin: 70)
    @invoice = invoice
    write_lines
  end

  def write_lines
    text "Invoice", align: :center, style: :bold, size: 28
    company_logo
    move_down 30
    header
    move_down 10
    body
    bounding_box [bounds.left, bounds.bottom + 18], width: bounds.width do
      footer
    end
  end

  def company_logo
    bounding_box([0, cursor], width: 100) do
      image "#{Rails.root}/app/assets/images/logo.jpg", height: 100, width: 100 , at: [0,30]
    end
  end

  def header
    table([["", invoice_id_and_date]], column_widths: [270, 270], cell_style: {border_width: 0})
  end

  def invoice_id_and_date
    data = [
      ["Invoice Number:", "##{1000000000+@invoice.id}"],
      ["Date:", @invoice.date]
    ]

    make_table(data, column_widths: [135, 135], cell_style: {border_width: 0}) do
      style(column(0), align: :right)
    end
  end

  def body
    serial_number = 1
    data = []
    @invoice.purchase_items.each do |item|
      data <<
        [
          serial_number,
          item.product.name,
          item.product.category.name,
          item.product.brand.name,
          item.product.uom.abbreviation,
          item.quantity,
          item.rate,
          item.amount
        ]

      serial_number +=1
    end

    headers = [["S.No", "Product", "Category", "Brand", "UOM", "Qty", "Rate", "Amount"]]
    table( headers, column_widths: [37.5, 117.5, 102.5, 77.5, 42.5, 37.5, 57.5, 67.5], cell_style: {borders: [:top, :bottom]}) do
      row(0).font_style = :bold
    end

    table( data, column_widths: [37.5, 117.5, 102.5, 77.5, 42.5, 37.5, 57.5, 67.5], cell_style: {borders: [:top]})
  end

  def footer
    table([["Total:", @invoice.order_value]], column_widths: [472.5, 67.5], cell_style: {borders: [:top]}) do
      style(column(0), align: :right)
      row(0).font_style = :bold
    end
  end

end
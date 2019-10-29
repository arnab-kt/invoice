require 'prawn'
class InvoicePdf < Prawn::Document

  def initialize(invoice)
    super(top_margin: 30)
    @invoice = invoice
    write_lines
  end

  def write_lines
    header
    move_down 50
    body
    footer
  end

  def footer
    repeat :all do
      bounding_box [bounds.left, bounds.bottom + 18], width: bounds.width do
        table([["TOTAL ORDER VALUE:", @invoice.order_value]], column_widths: [472.5, 67.5], cell_style: {borders: [:top]}) do
          style(column(0), align: :right)
          row(0).font_style = :bold
        end
      end
    end
  end

  def body
    data = []
    serial_number = 1
    items_per_page_counter = 1
    page_total = 0
    purchase_items = @invoice.purchase_items
    purchase_items.each_with_index do |item, index|
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
      items_per_page_counter += 1
      page_total += item.amount

      if items_per_page_counter == 2
        items_table_header
      end

      items_table_body(data)
      data = []

      if items_per_page_counter == 11
        items_table_footer(page_total)
        items_per_page_counter = 1
        page_total = 0
        if purchase_items[index+1].present?
          start_new_page
          header
          move_down 50
        end
      end
    end

    if items_per_page_counter > 1
      items_table_footer(page_total)
    end
  end

  def items_table_footer(page_total)
    table([["Total", page_total]], column_widths: [472.5, 67.5]) do
      column(0..1).each do |c|
        c.align = :right
      end
      row(0).font_style = :bold
    end
  end

  def items_table_header
    headers = [["S.No", "Product", "Category", "Brand", "UOM", "Qty", "Rate", "Amount"]]
    table( headers, column_widths: [37.5, 117.5, 102.5, 77.5, 42.5, 37.5, 57.5, 67.5]) do
      row(0).font_style = :bold
      column(0).align = :right
      column(5..7).each do |c|
        c.align = :right
      end
    end
  end


  def items_table_body(data)
    table( data, column_widths: [37.5, 117.5, 102.5, 77.5, 42.5, 37.5, 57.5, 67.5], cell_style: { padding_top: 16, padding_bottom: 16}) do
      column(0).borders = [:left]
      column(0).align = :right
      column(1..6).each do |c|
        c.borders = [:left, :right]
      end
      column(7).borders = [:right]

      column(5..7).each do |c|
        c.align = :right
      end
    end
  end

  def header
    bounding_box [bounds.left, bounds.top], width: bounds.width do
      logo_path = "#{Rails.root}/app/assets/images/main_logo.png"
      table([
        [ {image: logo_path, image_height: 103, image_width: 100}, company_name, invoice_id_and_date]
      ],cell_style: {border_width: 0, padding: 0}, column_widths: [100, 180, 260]) do
        style(column(2), align: :right)
        column(2).font_style = :bold
        column(2).size = 30
      end
    end
  end

  def invoice_id_and_date
    data = [
      [{content: "INVOICE", colspan: 2}],
      ["Invoice Number:", "##{1000000000+@invoice.id}"],
      ["Date:", @invoice.date]
    ]

    make_table(data, cell_style: {border_width: 0}, column_widths: [175, 85]) do
      style(column(0), align: :right)
      row(0).column(0).font_style = :bold
      row(0).column(0).size =28
    end
  end


  def company_name
    data = [
      ["Kreeti Technologies Pvt. Ltd."],
      ["Innovation And Development"],
      [""],
      ["1408, Godrej Genesis"],
      ["Website: www.kreeti.com"],
      ["CIN: U46785385835IH6"]
    ]

    make_table(data, cell_style: {border_width: 0, width: 300, height: 21}, column_widths: [180]) do
      row(0).font_style = :bold
      rows(0..1).each do |r|
        r.size = 10
      end

      rows(2..5).each do |r|
        r.height = 16
        r.size = 7
      end
    end
  end
end
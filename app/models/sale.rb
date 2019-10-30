class Sale < ApplicationRecord
  has_many :sale_items, dependent: :destroy
  accepts_nested_attributes_for :sale_items, reject_if: :all_blank, allow_destroy: true

  scope :order_by_sale_date, -> { order(date: :desc, id: :desc) }

  def order_value
    total_price = 0
    sale_items.each do |item|
      total_price += item.amount
    end
    return total_price
  end
end

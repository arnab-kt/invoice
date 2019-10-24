class Purchase < ApplicationRecord

  has_many :purchase_items, dependent: :destroy
  accepts_nested_attributes_for :purchase_items, reject_if: :all_blank, allow_destroy: true

  scope :order_by_purchase_date, -> { order(date: :desc, id: :desc) }

  def order_value
    total_price = 0
    purchase_items.each do |item|
      total_price += item.amount
    end
    return total_price
  end
end

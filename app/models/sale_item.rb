class SaleItem < ApplicationRecord
  belongs_to :product
  belongs_to :sale

  validates :quantity, :rate, presence: true

  def amount
    return quantity * rate
  end
end

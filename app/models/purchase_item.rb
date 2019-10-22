class PurchaseItem < ApplicationRecord
  belongs_to :product
  belongs_to :purchase

  validates :quantity, :rate, presence: true

  def amount
    return quantity * rate
  end
end

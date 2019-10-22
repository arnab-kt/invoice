class Purchase < ApplicationRecord

  has_many :purchase_items
  accepts_nested_attributes_for :purchase_items, allow_destroy: true
end

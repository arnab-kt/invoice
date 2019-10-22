class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  belongs_to :uom

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :active, inclusion: { in: [ true, false ] }
end

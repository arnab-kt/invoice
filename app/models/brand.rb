class Brand < ApplicationRecord

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :active, inclusion: { in: [ true, false ] }

  scope :active_brands, ->{ where(active: true) }
end

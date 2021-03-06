class Category < ApplicationRecord

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :active, inclusion: { in: [ true, false ] }

  scope :active_categories, ->{ where(active: true) }
end

class Category < ApplicationRecord

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :active, inclusion: { in: [ true, false ] }
end

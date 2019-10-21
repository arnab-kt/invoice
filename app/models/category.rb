class Category < ApplicationRecord

  validates :name, presence: true, uniqueness: { case_sensitive: true }
  validates :active, presence: true
end

class Brand < ApplicationRecord

  validates :name, presence: true, uniqueness: { case_sensitive: true }
  validates :active, inclusion: { in: [ true, false ] }
end

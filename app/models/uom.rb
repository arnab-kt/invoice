class Uom < ApplicationRecord

  validates :name, :abbreviation, presence: true, uniqueness: { case_sensitive: false }
  validates :active, inclusion: { in: [ true, false ] }

  scope :active_uoms, ->{ where(active: true) }
end

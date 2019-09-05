class Street < ApplicationRecord
  has_many :commune_streets
  has_many :communes, through: :commune_streets

  validates_presence_of :title
  validates :from, numericality: true, allow_nil: true
  validates :to, numericality: { greater_than: :from }, allow_nil: true
end

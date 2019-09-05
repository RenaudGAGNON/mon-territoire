class CommuneStreet < ApplicationRecord
  belongs_to :commune
  belongs_to :street
end

class Commune < ApplicationRecord
  belongs_to :intercommunality, optional: true
  has_many :commune_streets
  has_many :streets, through: :commune_streets

  validates_presence_of :name
  validates :code_insee, presence: true, length: {is: 5}

  def self.search(search)
    where(Commune.arel_table[:name].lower.matches("%#{sanitize_sql_like(search.downcase)}%"))
  end

  def self.to_hash
    all.map{ |c| [c.code_insee, c.name] }.to_h
  end
end

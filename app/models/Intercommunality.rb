class Intercommunality < ApplicationRecord

  # enum form: %w(ca cu cc met)

  has_many :communes

  validates_presence_of :name 
  validates :siren, presence: true, uniqueness: true, case_sensitive: false, format: { with: /\A[0-9]{9}\z/ }
  validates :form, presence: true, inclusion: { in: %w(ca cu cc met) }

  before_save :compute_slug

  def communes_hash
    communes.pluck(:code_insee, :name).to_h
  end

  def population
    communes.sum(:population)
  end

private

  def compute_slug
    self.slug = name.try(:parameterize) if self.slug.blank?
  end
end
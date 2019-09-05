class Intercommunality < ApplicationRecord

  # enum form: %w(ca cu cc met)

  has_many :communes

  validates_presence_of :name, :form
  validates :siren, presence: true, format: { with: /\A[0-9]{9}\z/ }
  validates_uniqueness_of :siren, case_sensitive: false
  validates :form, inclusion: { in: %w(ca cu cc met) }

  before_save :compute_slug


  def communes_hash
    communes.map{ |c| [c.code_insee, c.name] }.to_h
  end

  def population
    communes.sum(:population)
  end

private

  def compute_slug
    self.slug = name.try(:parameterize) if self.slug.blank?
  end
end
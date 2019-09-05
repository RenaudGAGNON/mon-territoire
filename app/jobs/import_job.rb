class ImportJob < ActiveJob::Base
  def perform(csv)
    require "csv"
    csv_text = File.read(csv)
    csv = CSV.parse(csv_text, headers: true, col_sep: ";")
    csv.each do |row|
      intercommunality = Intercommunality.create_with(siren: row["siren_epci"], name: row["nom_complet"], form: convert_to_form(row["form_epci"])).find_or_create_by(siren: row["siren_epci"])
      Commune.create_with(intercommunality: intercommunality, code_insee: row["insee"], name: row["nom_com"], population: row["pop_total"]).find_or_create_by(code_insee: row["insee"])
    end
  end

  def convert_to_form(form)
    form.downcase.to 2
  end
end

class AddPopulationToCommune < ActiveRecord::Migration[5.0]
  def change
    add_column :communes, :population, :integer
  end
end

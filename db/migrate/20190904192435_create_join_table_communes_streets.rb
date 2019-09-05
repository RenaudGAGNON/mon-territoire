class CreateJoinTableCommunesStreets < ActiveRecord::Migration[5.0]
  def change
    create_join_table :communes, :streets do |t|
      t.index [:commune_id, :street_id]
      t.index [:street_id, :commune_id]
    end
  end
end

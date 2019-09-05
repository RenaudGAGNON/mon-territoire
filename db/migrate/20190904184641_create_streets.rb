class CreateStreets < ActiveRecord::Migration[5.0]
  def change
    create_table :streets do |t|
      t.string :title
      t.integer :from
      t.integer :to
    end
  end
end

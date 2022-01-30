class CreateClothes < ActiveRecord::Migration[6.1]
  def change
    create_table :clothes do |t|
      t.string :outfit_name
      t.string :weather
      t.string :outfit_type

      t.timestamps
    end
  end
end

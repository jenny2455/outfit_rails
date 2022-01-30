class AddUserIdToClothes < ActiveRecord::Migration[6.1]
  def change
    add_column :clothes, :user_id, :integer
    add_index :clothes, :user_id
  end
end

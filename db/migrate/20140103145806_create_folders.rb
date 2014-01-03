class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :category
      t.string :unique_id
      t.integer :user_id

      t.timestamps
    end
  end
end

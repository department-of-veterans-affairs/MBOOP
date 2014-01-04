class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :folder_id
      t.text :action

      t.timestamps
    end
  end
end

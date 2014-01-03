class AddCompletedToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :completed, :boolean, :default => false
  end
end

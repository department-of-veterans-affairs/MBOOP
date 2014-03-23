class AddSubjectToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :subject, :string
  end
end

class Folder < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true
  validates :category, :presence => true
  validates :unique_id, :presence => true
  validates :unique_id, uniqueness: true
  
  FOLDER_CATEGORIES = ["green", "blue", "yellow"]
end

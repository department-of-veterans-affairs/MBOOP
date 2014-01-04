require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/svg_outputter'

class Folder < ActiveRecord::Base
  belongs_to :user
  has_many :histories
  validates :user_id, :presence => true
  validates :category, :presence => true
  validates :unique_id, :presence => true
  validates :unique_id, uniqueness: true
  
  FOLDER_CATEGORIES = ["green", "blue", "yellow"]

end

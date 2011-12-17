class Painting < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	has_many :comments
	belongs_to :album
	validates_presence_of :title
end

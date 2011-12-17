class Comment < ActiveRecord::Base
	belongs_to :painting
	validates_presence_of :comment_dec
end

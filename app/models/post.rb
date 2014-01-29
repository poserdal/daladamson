class Post < ActiveRecord::Base
	belongs_to :user
	has_attached_file :image, :styles => { :medium => "300x800>", :thumb => "100x300>"}
	
end

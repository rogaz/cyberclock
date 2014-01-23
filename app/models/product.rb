class Product < ActiveRecord::Base

  belongs_to :company

  has_and_belongs_to_many :branches

  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

end

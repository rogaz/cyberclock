class Product < ActiveRecord::Base

  belongs_to :company

  has_and_belongs_to_many :branches

  validates :description, presence: true

  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_presence :picture

end

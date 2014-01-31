class Company < ActiveRecord::Base

  has_many :branches
  has_many :promotions
  has_many :products
  has_many :rules

  belongs_to :admin, class_name: 'User'

end

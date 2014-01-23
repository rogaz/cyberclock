class Branch < ActiveRecord::Base

  has_many :computers

  belongs_to :admin, class_name: 'User'
  belongs_to :company

  has_and_belongs_to_many :rules
  has_and_belongs_to_many :products
  has_and_belongs_to_many :promotions

end

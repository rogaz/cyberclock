class Branch < ActiveRecord::Base

  has_many :computers

  belongs_to :admin, class_name: 'User'
  belongs_to :company

end

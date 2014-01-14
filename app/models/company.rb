class Company < ActiveRecord::Base

  has_many :branches
  has_many :promotions
  has_many :rules


end

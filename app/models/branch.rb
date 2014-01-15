class Branch < ActiveRecord::Base

  belongs_to :company

  has_many :computers

end

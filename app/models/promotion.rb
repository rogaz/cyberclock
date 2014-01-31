class Promotion < ActiveRecord::Base

  belongs_to :company

  has_and_belongs_to_many :branches

  validates :description, presence: true

end

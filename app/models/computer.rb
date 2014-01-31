class Computer < ActiveRecord::Base

  belongs_to :branch

  validates :name, presence: true

end

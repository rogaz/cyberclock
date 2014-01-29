class Computer < ActiveRecord::Base

  validates :name, presence: true

  belongs_to :branch

end

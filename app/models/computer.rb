class Computer < ActiveRecord::Base

  has_many :rents

  belongs_to :branch

  validates :name, presence: true

  def last_rent
    self.rents.order('created_at DESC').limit(1)[0]
  end

end

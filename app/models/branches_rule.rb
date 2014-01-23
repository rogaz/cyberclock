class BranchesRule < ActiveRecord::Base

  belongs_to :branch
  belongs_to :rule

end

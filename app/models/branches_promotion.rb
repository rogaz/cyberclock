class BranchesPromotion < ActiveRecord::Base
  belongs_to :branch
  belongs_to :promotion
end

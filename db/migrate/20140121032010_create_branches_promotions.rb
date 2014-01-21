class CreateBranchesPromotions < ActiveRecord::Migration
  def change
    create_table :branches_promotions, id: false do |t|
      t.references :branch, index: true
      t.references :promotion, index: true
    end
  end
end

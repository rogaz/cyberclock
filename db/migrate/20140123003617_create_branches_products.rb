class CreateBranchesProducts < ActiveRecord::Migration
  def change
    create_table :branches_products, id: false do |t|
      t.references :branch, index: true
      t.references :product, index: true
    end
  end
end

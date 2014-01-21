class CreateBranchesRules < ActiveRecord::Migration
  def change
    create_table :branches_rules, id: false do |t|
      t.references :branch, index: true
      t.references :rule, index: true
    end
  end
end

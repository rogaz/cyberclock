class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :name
      t.references :company, index: true

      t.timestamps
    end
  end
end

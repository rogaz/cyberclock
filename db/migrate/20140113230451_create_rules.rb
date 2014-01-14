class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.text :description
      t.references :company, index: true

      t.timestamps
    end
  end
end

class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :description
      t.references :company, index: true

      t.timestamps
    end
  end
end

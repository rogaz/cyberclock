class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :description
      t.references :company, index: true

      t.timestamps
    end
  end
end

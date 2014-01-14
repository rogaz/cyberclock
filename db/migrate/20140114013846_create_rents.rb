class CreateRents < ActiveRecord::Migration
  def change
    create_table :rents do |t|
      t.string :name
      t.time :duration
      t.string :rent_type
      t.references :computer, index: true

      t.timestamps
    end
  end
end

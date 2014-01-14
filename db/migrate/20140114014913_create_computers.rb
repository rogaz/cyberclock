class CreateComputers < ActiveRecord::Migration
  def change
    create_table :computers do |t|
      t.string :name
      t.references :branch, index: true

      t.timestamps
    end
  end
end

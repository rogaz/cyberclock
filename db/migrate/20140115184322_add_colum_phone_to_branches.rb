class AddColumPhoneToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :phone, :string
  end
end

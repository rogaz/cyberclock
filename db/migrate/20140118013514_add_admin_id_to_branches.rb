class AddAdminIdToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :admin_id, :integer, index: true
  end
end

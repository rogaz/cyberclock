class AddAdminIdToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :admin_id, :integer, index: true
  end
end

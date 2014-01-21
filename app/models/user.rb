class User < ActiveRecord::Base

  easy_roles :roles

  acts_as_authentic do |config|
    config.crypto_provider = Authlogic::CryptoProviders::MD5
  end

  ROLES = %w(admin admin_company admin_branch user)

  has_one :company, class_name: 'Company', foreign_key: 'admin_id'
  has_one :branch, class_name: 'Branch', foreign_key: 'admin_id'

  before_destroy :remove_admin_id

  def remove_admin_id
    if self.is_admin_company?
      Company.find_all_by_admin_id(self.id).each {|company| company.update_attribute('admin_id', nil)}
    elsif self.is_admin_branch?
      Branch.find_all_by_admin_id(self.id).each {|branch| branch.update_attribute('admin_id', nil)}
    end
  end

end

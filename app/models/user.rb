class User < ActiveRecord::Base

  easy_roles :roles

  acts_as_authentic do |config|
    config.crypto_provider = Authlogic::CryptoProviders::MD5
  end

  ROLES = %w(admin admin_company admin_branch user)

  before_destroy :remove_admin_id

  def remove_admin_id
    if self.is_admin_company?
      Company.find_all_by_admin_id(self.id).each {|company| company.update_attribute('admin_id', nil)}
    elsif self.is_admin_branch?
      Branch.find_all_by_admin_id(self.id).each {|branch| branch.update_attribute('admin_id', nil)}
    end
  end

end

class User < ActiveRecord::Base

  easy_roles :roles

  acts_as_authentic do |config|
    config.crypto_provider = Authlogic::CryptoProviders::MD5
  end

  ROLES = %w(admin admin_company user)

end

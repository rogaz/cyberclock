class Branch < ActiveRecord::Base

  has_many :computers

  belongs_to :admin, class_name: 'User'
  belongs_to :company

  has_and_belongs_to_many :rules
  has_and_belongs_to_many :products
  has_and_belongs_to_many :promotions

  validates :name, presence: true

  after_destroy :destroy_admin

  def destroy_admin
    self.admin.destroy if self.admin
  end

  #TODO: Buscar la manera de hacer este método con un scope
  def rules_unassigned
    rules = self.rules
    all_rules = self.company.rules.order(:description)
    all_rules - rules
  end

  def promotions_unassigned
    promotions = self.promotions
    all_promotions = self.company.promotions.order(:description)
    all_promotions - promotions
  end

  def products_unassigned
    all_products = self.company.products.order(:description)
    all_products - self.products
  end

end

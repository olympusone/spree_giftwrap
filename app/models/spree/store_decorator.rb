module Spree::StoreDecorator
  def self.prepended(base)
    base.preference :giftwrap_cost, :decimal, default: 0.0
  end
end

::Spree::Store.prepend(Spree::StoreDecorator)
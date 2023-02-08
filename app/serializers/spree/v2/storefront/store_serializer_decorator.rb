module Spree::V2::Storefront::StoreSerializerDecorator
  def self.prepended(base)
      base.attribute :giftwrap_cost do |store|
        store.preferred_giftwrap_cost
      end
  end
end

::Spree::V2::Storefront::StoreSerializer.prepend(Spree::V2::Storefront::StoreSerializerDecorator)
module Spree::LineItemDecorator
    def self.prepended(base)
        base.before_save :save_giftwrap_adjustment

        def save_giftwrap_adjustment
          if self.giftwrap?
            adjustment_count = self.adjustments.where(source_type: "Spree::GiftWrap").count

            if adjustment_count < quantity
              (quantity - adjustment_count).times do
                self.adjustments.build(
                  label: Spree.t('giftwrap'),
                  source_type: "Spree::GiftWrap",
                  amount: Spree::Store.current.preferred_giftwrap_cost,
                  order: self.order,
                )
              end
            else
              self.adjustments.where(source_type: "Spree::GiftWrap")
                .limit(adjustment_count - quantity)
                .delete_all
            end
          else
            self.adjustments.where(source_type: "Spree::GiftWrap").delete_all
          end
        end
    end
end
  
::Spree::LineItem.prepend(Spree::LineItemDecorator)
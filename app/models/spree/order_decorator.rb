module Spree::OrderDecorator
    def compare_line_item_giftwrap(_line_item, _options)
        _line_item.giftwrap == _options[:giftwrap]
    end
end
  
::Spree::Order.prepend(Spree::OrderDecorator)
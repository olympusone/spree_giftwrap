class AddSpreeLineItemsGiftwrapColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_line_items, :giftwrap, :boolean, default: false
  end
end

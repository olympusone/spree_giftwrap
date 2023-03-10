module SpreeGiftwrap
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_giftwrap'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    config.after_initialize do
      Spree::PermittedAttributes.store_attributes << :preferred_giftwrap_cost
      Spree::PermittedAttributes.line_item_attributes << :giftwrap

      config.spree.line_item_comparison_hooks.add 'compare_line_item_giftwrap'
    end

    initializer 'spree_giftwrap.environment', before: :load_config_initializers do |_app|
      SpreeGiftwrap::Config = SpreeGiftwrap::Configuration.new
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end

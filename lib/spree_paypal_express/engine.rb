module SpreePaypalExpress
  class Engine < Rails::Engine
    engine_name 'spree_paypal_express'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
    end

    config.after_initialize do |app|
      app.config.spree.payment_methods += [
        Spree::BillingIntegration::PaypalExpress,
        Spree::BillingIntegration::PaypalExpressUk
      ]
    end

    # The install generator tries to do spree_paypal_express.classify => SpreePaypalExpres
    # This fixes that 's' from getting chopped off
    ActiveSupport::Inflector.inflections do |inflect|
      inflect.singular 'express', 'express'
    end

    config.to_prepare &method(:activate).to_proc
  end
end

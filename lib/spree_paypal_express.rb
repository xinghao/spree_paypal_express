require 'spree_core'

module SpreePaypalExpress
  class Engine < Rails::Engine
    engine_name 'spree_paypal_express'

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
    end

    initializer "spree_paypal_express.register.payment_methods" do |app|
      app.config.spree.payment_methods += [
        BillingIntegration::PaypalExpress,
        BillingIntegration::PaypalExpressUk
      ]
    end

    config.to_prepare &method(:activate).to_proc
  end
end

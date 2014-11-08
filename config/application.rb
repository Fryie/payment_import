require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PaymentImport
  class Application < Rails::Application
    config.sequel.after_connect = proc do
      Sequel::Model.plugin :active_model
      Sequel::Model.plugin :validation_helpers
      Sequel::Model.plugin :dirty
      Sequel::Model.plugin :association_proxies
      Sequel::Model.plugin :timestamps, update_on_create: true
    end
  end
end

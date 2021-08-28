require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WCPPortfolio
  class Application < Rails::Application
    config.i18n.default_locale = :ja
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    # # アプリケーションが対応している言語のホワイトリスト(ja = 日本語, en = 英語)
    #   config.i18n.available_locales = %i(ja en)

    #   # 上記の対応言語以外の言語が指定された場合、エラーとするかの設定
    #   config.i18n.enforce_available_locales = true

    #   # タイムゾーンを日本時間に設定
    #   config.time_zone = 'Asia/Tokyo'
  end
end

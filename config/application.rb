require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Hwk
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    # config.active_record.whitelist_attributes = true
    # config.active_record.whitelist_attributes = false

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # GERTIG - this allows me to have multiple manifests just like application.js / .css
    # that I can call from other layouts. Just be sure to use a name like cool-page-manifest.js
    config.assets.precompile += ["*-manifest.js", "*-manifest.css"]


    #GERTIG - fixes assets on Heroku
    config.assets.initialize_on_precompile = false

    # GERTIG - Don't generate the javascript and css files with generators
    config.generators.stylesheets = false
    config.generators.javascripts = false

    # I18n.enforce_available_locales = false
    config.i18n.enforce_available_locales = false


    #GERTIG - uses rack-rewrite gem to rewrite the sitemap URL to point to amazon S3
    config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
      # rewrite rules here
      # r302 %r{^/sitemap.xml}, "http://#{ENV['FOG_HOST']}/sitemaps/sitemap1.xml.gz"
      # 301 is a permananet redirect (recommended)
      # 302 is a temoporary redirect

      r301 '/pff',   '/preschool-farm-fun'
      r302 '/pff-app',  'https://itunes.apple.com/us/app/preschool-farm-fun/id875654180?mt=8'
      r301 '/ios-for-parents', '/ios-for-parents-guide-to-iphone-ipad-ipod-security-and-safety'
      r301 '/guide', '/ios-for-parents-guide-to-iphone-ipad-ipod-security-and-safety'

      # redirects the sitemap URL to point to amazon S3
      r302 %r{^/sitemap.xml}, "http://humanswithkids-assets.s3-website-us-east-1.amazonaws.com/sitemaps/sitemap1.xml.gz"

      # redirects the root humanswithkids.com to www.humanswithkids.com
      r301 %r{.*}, 'http://www.humanswithkids.com$&', :if => Proc.new {|rack_env|
        # Rails.logger.info "PATH: #{rack_env['PATH_INFO']} matches Regex? #{rack_env['PATH_INFO'] === %r{\/tag\/.*$}}"
        rack_env['SERVER_NAME'] == 'humanswithkids.com'
        # || rack_env['PATH_INFO'] === %r{\/tag\/.*$}
      }

      # redirects any url that ends in a / (forward slash) to the clean url without it
      # http://rubular.com/r/rfCmOBjays
      r301 %r{(.+)\/$}, '$1', :if => Proc.new { |rack_env|
        rack_env['SERVER_NAME'] != "localhost"
      }

      # redirects any url that ends in a /comment-page-1 (forward slash) to the clean url without it
      # http://rubular.com/r/rfCmOBjays
      r301 %r{(.+)\/comment-page-1$}, '$1', :if => Proc.new { |rack_env|
        rack_env['SERVER_NAME'] != "localhost"
      }

      # redirects any url that ends in a /tag/something (forward slash) to the clean url with ?tag=something
      # http://rubular.com/r/rfCmOBjays
      # r301 %r{(.+)\/tag\/(.*)$}, '$1', :if => Proc.new { |rack_env|
      #   rack_env['SERVER_NAME'] != "localhost"
      # }


      #Rails Request.env Variables
      # SERVER_NAME
      # PATH_INFO
      # REMOTE_HOST
      # HTTP_ACCEPT_ENCODING
      # HTTP_USER_AGENT
      # SERVER_PROTOCOL
      # HTTP_CACHE_CONTROL
      # HTTP_ACCEPT_LANGUAGE
      # HTTP_HOST
      # REMOTE_ADDR
      # SERVER_SOFTWARE
      # HTTP_KEEP_ALIVE
      # HTTP_REFERER
      # HTTP_COOKIE
      # HTTP_ACCEPT_CHARSET
      # REQUEST_URI
      # SERVER_PORT
      # GATEWAY_INTERFACE
      # QUERY_STRING
      # REMOTE_USER
      # HTTP_ACCEPT
      # REQUEST_METHOD
      # HTTP_CONNECTION

    end


  end
end

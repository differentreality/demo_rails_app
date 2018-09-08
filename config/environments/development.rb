Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Set the detault url for action mailer
  # config.action_mailer.default_url_options = { host: 'my.host' }
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  # config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  # config.action_mailer.default :charset => "utf-8"

  # config.action_mailer.smtp_settings = {
  #   address: "mymail",
  #   port: 25,
  #   domain: "mydomain"
  # }

  # Use omniauth mock credentials
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:facebook] =
      OmniAuth::AuthHash.new(
                              provider: 'facebook',
                              uid: 'facebook-test-uid-1',
                              info: {
                                name: 'facebook user',
                                email: 'facebook_user@example.com',
                                username: 'facebook_user'
                              },
                              credentials: {
                                token: 'fb_mock_token',
                                secret: 'fb_mock_secret'
                              }
                            )

  OmniAuth.config.mock_auth[:google] =
      OmniAuth::AuthHash.new(
                              provider: 'google',
                              uid: 'google-test-uid-1',
                              info: {
                                name: 'google user',
                                email: 'google_user@example.com',
                                username: 'google_user'
                              },
                              credentials: {
                                token: 'google_mock_token',
                                secret: 'google_mock_secret'
                              }
                            )

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # config.assets.precompile += %w( gsis.js )
  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.action_mailer.smtp_settings = {
    address:              ENV['SMTP_ADDRESS'],
    port:                 ENV['SMTP_PORT'],
    user_name:            ENV['SMTP_USERNAME'],
    password:             ENV['SMTP_PASSWORD'],
    authentication:       ENV['SMTP_AUTHENTICATION'].try(:to_sym),
    domain:               ENV['SMTP_DOMAIN'],
    enable_starttls_auto: ENV['SMTP_ENABLE_STARTTLS_AUTO'],
    openssl_verify_mode:  ENV['SMTP_OPENSSL_VERIFY_MODE']
  }
end

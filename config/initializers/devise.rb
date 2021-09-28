# frozen_string_literal: true

Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  google_client_id = Rails.application.credentials.google[:google_client_id]
  google_client_secret = Rails.application.credentials.google[:google_client_secret]
  Rails.application.credentials.secret_key_base
  # available as additional gems.
  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 12

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

  config.omniauth :google_oauth2, google_client_id, google_client_secret
  # { scope: 'email', info_fields: 'email, name' }
end

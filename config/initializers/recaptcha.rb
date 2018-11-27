# frozen_string_literal: true

Recaptcha.configure do |config|
  config.site_key = ENV['GOOGLE_CAPTCHA_KEY']
  config.secret_key = ENV['GOOGLE_CAPTCHA_SECRET']
end

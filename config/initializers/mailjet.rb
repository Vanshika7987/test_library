# kindly generated by appropriated Rails generator
Mailjet.configure do |config|
  config.api_key = '34e3735eb7941ac4a8b86fc69d1fe8ec'
  config.secret_key = 'f834c893213263e5fab65ae0b5824746'
  config.default_from = 'vanshikakumrawat889@outlook.com'
  # config.default_from = 'vanshikakumrawat9425@gmail.com'
  # Mailjet API v3.1 is at the moment limited to Send API.
  # We’ve not set the version to it directly since there is no other endpoint in that version.
  # We recommend you create a dedicated instance of the wrapper set with it to send your emails.
  # If you're only using the gem to send emails, then you can safely set it to this version.
  # Otherwise, you can remove the dedicated line into config/initializers/mailjet.rb.
  config.api_version = 'v3.1'
end

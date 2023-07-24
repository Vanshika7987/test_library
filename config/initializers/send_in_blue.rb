SibApiV3Sdk.configure do |config|
  config.api_key['api-key'] = Rails.application.credentials.development[:send_in_blue][:api_key]
  # config.default_from = 'vanshikakumrawat889@outlook.com'
end
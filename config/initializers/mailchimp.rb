# Gibbon::Export.throws_exceptions = false

if Rails.env.production? || !ENV['HIT_MAILCHIMP'].blank?
  Rails.configuration.mailchimp = Gibbon::API.new(MAILCHIMP_API || ENV['MAILCHIMP_API'])
end

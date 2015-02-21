# Gibbon::Export.throws_exceptions = false

if Rails.env.production? || !ENV['HIT_MAILCHIMP'].blank?
  Rails.configuration.mailchimp = Gibbon::API.new(Rails.application.secrets.mailchimp_api)
end

MAILCHIMP_LIST_ID = Rails.application.secrets.mailchimp_list_id

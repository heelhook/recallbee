module NewsletterSubscribable
  extend ActiveSupport::Concern

  included do
    after_create :subscribe_to_mailchimp
    after_update :subscribe_to_mailchimp, unless: -> user { user.subscribed_to_mailchimp? }
  end

  def subscribe_to_mailchimp
    return true if !defined?(Rails.configuration.mailchimp?) || email.blank?

    begin
      response = Rails.configuration.mailchimp.lists.subscribe({
        id: MAILCHIMP_LIST_ID,
        email: { email: email },
        merge_vars: {
          FNAME: first_name,
          LNAME: last_name,
        },
        double_optin: false,
      })

      update_attributes(subscribed_to_mailchimp: true)
    rescue Gibbon::MailChimpError => e
    end
  end
end

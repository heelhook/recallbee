class User < ActiveRecord::Base
  has_many :children
  has_many :toys, through: :children
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable

  after_create :subscribe_to_mailchimp
  after_update :subscribe_to_mailchimp, unless: -> user { user.subscribed_to_mailchimp? }

  def self.create_from_omniauth(params)
    attributes = {
      email: params['info']['email'],
      first_name: params['info']['first_name'],
      last_name: params['info']['last_name'],
      image: params['info']['image'],
      password: Devise.friendly_token
    }

    create(attributes)
  end

  private

  def subscribe_to_mailchimp
    return true unless Rails.configuration.mailchimp || email.blank?

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

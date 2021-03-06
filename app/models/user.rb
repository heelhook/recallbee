class User < ActiveRecord::Base
  include NewsletterSubscribable

  has_many :children, foreign_key: :parent_id, dependent: :destroy
  has_many :toys, through: :children
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  has_many :alerts, through: :children
  has_many :acknowledged_alerts, through: :children
  has_many :unacknowledged_alerts, through: :children

  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable

  validates :email, uniqueness: { case_sensitive: false }

  after_create :send_email

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

  def send_email
    TransactionMailer.welcome(self).deliver
  end
end

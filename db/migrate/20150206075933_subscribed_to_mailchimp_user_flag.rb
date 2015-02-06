class SubscribedToMailchimpUserFlag < ActiveRecord::Migration
  def change
    add_column :users, :subscribed_to_mailchimp, :boolean, default: false
  end
end

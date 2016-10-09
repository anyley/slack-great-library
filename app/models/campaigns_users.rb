class CampaignsUsers < ApplicationRecord
  belongs_to :campaign
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :campaign_id
end

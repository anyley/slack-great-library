class User < ApplicationRecord
  before_create :set_name, if: 'name.nil?'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable #, :omniauth_providers => [:github]

  has_and_belongs_to_many :items

  has_many :offers, foreign_key: :offered_by_id, class_name: 'Item'

  has_many :purchases
  has_many :purchase_items, through: :purchases, source: :item

  has_many :claims
  has_many :claim_items, through: :claims, source: :item

  has_many :sended_ops, foreign_key: :sender_id, class_name: 'Operation'
  has_many :received_ops, foreign_key: :receiver_id, class_name: 'Operation'

  has_many :self_campaigns, foreign_key: :initiator_id, class_name: 'Campaign'

  # has_many :campaigns_users
  # has_many :other_campaigns, through: :campaigns_users, source: :campaign
  has_and_belongs_to_many :campaigns

  default_scope { order :name, :email }

  scope :list_requested, -> (item_id) do
    where.not(
        id: User.joins(:purchases).where(purchases: { item_id: item_id })
    ).where(
        id: User.joins(:claims).where(claims: { item_id: item_id })
    )
  end

  def other_items
    Item.other_items_for_user id
  end

  def set_name
    self.name = email.split('@').first
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = "#{auth.info.nickname}@github.com"
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.nickname
    end
  end
end


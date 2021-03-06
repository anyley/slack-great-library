class Item < ApplicationRecord
  belongs_to :offered_user, foreign_key: 'offered_by_id', class_name: 'User', primary_key: 'id'

  has_and_belongs_to_many :users

  has_many :purchases
  has_many :purchase_users, source: :user, through: :purchases

  has_many :claims
  has_many :claimers, through: :claims, source: :user

  has_many :campaigns

  default_scope { order :created_at }

  scope :other_items_for_user, -> (user_id) do
    joins(:purchases, :claims)
        .where.not(purchases: {user_id: user_id})
        .where.not(claims: {user_id: user_id})
  end

  # scope :new_requests_from_user, -> (user_id) do
  #   where.not(
  #       id: Item.joins(:purchases).where(purchases: { user_id: user_id })
  #   ).where(
  #       id: Item.joins(:claims).where(claims: { user_id: user_id })
  #   )
  # end
  #
  # scope :new_requests, -> do
  #   where.not(
  #       id: Item.joins(:purchases)
  #   ).where(
  #       id: Item.joins(:claims)
  #   )
  # end
end

class Item < ApplicationRecord
  belongs_to :offered_user, foreign_key: 'offered_by_id', class_name: 'User', primary_key: 'id'

  has_and_belongs_to_many :users

  has_many :purchases
  has_many :purchase_users, source: :user, through: :purchases

  has_many :claims
  has_many :claimers, through: :claims, source: :user
end

class Operation < ApplicationRecord
  belongs_to :sender, foreign_key: 'sender_id', class_name: 'User', primary_key: 'id'
  belongs_to :receiver, foreign_key: 'receiver_id', class_name: 'User', primary_key: 'id'

  has_and_belongs_to_many :users
end

class Campaign < ApplicationRecord
  belongs_to :initiator, foreign_key: 'initiator_id', class_name: 'User', primary_key: 'id'
  has_and_belongs_to_many :users

  STATUS = [ "Подтверждение заявок", "Сбор средств", "Завершено" ]
end

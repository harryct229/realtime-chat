class Chat < ActiveRecord::Base
  # Owner
  belongs_to :owner_user, class_name: 'User', foreign_key: :owner_id

  # Many to Many with User
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations, source: :user

  has_many :messages, dependent: :destroy
end

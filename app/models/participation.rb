class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat

  validates :user_id, presence: true, uniqueness: {:scope => :chat_id}
  validates :chat_id, presence: true
end

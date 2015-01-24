class Message < ActiveRecord::Base
  belongs_to :owner, class_name: :User, foreign_key: :sent_id
  belongs_to :chat
end

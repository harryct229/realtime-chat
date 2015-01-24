class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :participations, dependent: :destroy
  has_many :chats, through: :participations, source: :chat

  has_many :owned_chats, class_name: 'Chat', foreign_key: 'owner_id'

  has_many :messages, class_name: 'Message', foreign_key: 'sent_id', dependent: :destroy

  def join_in chat
    self.participations.create(chat_id: chat.id)
  end
end

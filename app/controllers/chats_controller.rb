class ChatsController < ApplicationController
  include Tubesock::Hijack

  before_action :set_chat, only: [:show, :edit, :update, :destroy, :chat]
  before_action :check_user_chat, only: [:show, :chat]

  def show

  end

  def chat
    hijack do |tubesock|
      # Listen on its own thread
      redis_thread = Thread.new do
        # Needs its own redis connection to pub
        # and sub at the same time
        Redis.new.subscribe "Chat_#{@chat.id}" do |on|
          on.message do |channel, message|
            message = JSON.parse(message)
            message = {"username" => User.find(message['user_id']).email, "message" => message['message']}.to_json
            tubesock.send_data message
          end
        end
      end

      tubesock.onmessage do |m|
        # pub the message when we get one
        # note: this echoes through the sub above
        Redis.new.publish "Chat_#{@chat.id}", m
      end

      tubesock.onclose do
        # stop listening when client leaves
        redis_thread.kill
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    def check_user_chat
      redirect_to root_path unless @chat.users.include?(current_user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chat_params
      params.require(:chat).permit(:name)
    end

end

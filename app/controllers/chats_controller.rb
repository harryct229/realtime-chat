class ChatsController < ApplicationController
  include Tubesock::Hijack

  before_action :set_chat, only: [:show, :edit, :update, :destroy, :chat, :messages]
  # before_action :check_user_chat, only: [:show, :chat]

  def index
    render json: Chat.all
  end

  def show
    render json: @chat
  end

  def create
    @chat = current_user.owned_chats.build(chat_params)

    respond_to do |format|
      if @chat.save
        current_user.join_in @chat
        format.html { redirect_to @chat, notice: 'Todo was successfully created.' }
        format.json { render json: @chat, status: :created, location: @chat }
      else
        format.html { render action: "new" }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  def messages
    @messages = []
    @chat.messages.each do |m|
      @messages << {message: m, owner: m.owner}
    end
    render json: @messages
  end

  def chat
    hijack do |tubesock|
      # Listen on its own thread
      redis_thread = Thread.new do
        # Needs its own redis connection to pub
        # and sub at the same time
        Redis.new.subscribe "Chat_#{@chat.id}" do |on|
          on.message do |channel, message|
            # message = JSON.parse(message)
            tubesock.send_data message
          end
        end
      end

      tubesock.onmessage do |m|
        # pub the message when we get one
        # note: this echoes through the sub above
        m = JSON.parse(m)
        @chat.messages.create(content: m['message'], sent_id: current_user.id)

        m = {"username" => current_user.email, "message" => m['message']}.to_json
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

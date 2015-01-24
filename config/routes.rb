RealtimeChat::Application.routes.draw do
  root to: "home#index"

  devise_for :users

  get '/chats/:id' => 'chats#show'
  get '/chat/:id' => 'chats#chat'

  scope :api do
    get "/chats(.:format)" => "chats#index"
    get "/chats/:id(.:format)" => "chats#show"
    get "/chats/:id/messages(.:format)" => "chats#messages"
  end

end

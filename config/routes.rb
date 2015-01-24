RealtimeChat::Application.routes.draw do
  root to: "home#index"

  devise_for :users

  get '/chats/:id' => 'chats#show'
  get '/chat/:id' => 'chats#chat'
end

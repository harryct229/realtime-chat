App.factory 'Screenchat', ['$resource', ($resource) ->
  $resource '/api/chats/:id', id: '@id'
  $resource "/chats.json", {},
    create:
      method: "POST"
]
App.factory 'ChatMessage', ['$resource', ($resource) ->
  $resource '/api/chats/:id/messages', id: '@id'
]
App.factory 'Screenchat', ['$resource', ($resource) ->
  $resource '/api/chats/:id', id: '@id'
]
App.factory 'ChatMessage', ['$resource', ($resource) ->
  $resource '/api/chats/:id/messages', id: '@id'
]
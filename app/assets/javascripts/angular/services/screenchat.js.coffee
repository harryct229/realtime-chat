App.factory 'Screenchat', ['$resource', ($resource) ->
  $resource '/api/chats/:id', id: '@id'
]
App.controller 'ScreenchatsCtrl', ['$scope', 'Screenchat', 'ChatMessage', ($scope, Screenchat, ChatMessage) ->
  # Attributes accessible on the view
  $scope.selectedScreenchat = null

  # Gather the screenchats and set the selected one to the first on success
  $scope.screenchats = Screenchat.query ->
    $scope.selectedScreenchat = $scope.screenchats[0]
    $scope.chatmessages = ChatMessage.query(id: $scope.selectedScreenchat.id)

  # Set the selected screenchat to the one which was clicked
  $scope.showScreenchat = (screenchat, row) ->
    $scope.selectedScreenchat = screenchat
    $scope.chatmessages = ChatMessage.query(id: $scope.selectedScreenchat.id)

  $scope.create = (screenchat) ->
    t = new Screenchat(screenchat)
    t.$create (screenchat) ->
      $scope.screenchats.push screenchat
      $scope.screenchat.name = ""
      $("form#new_room input").toggleClass("movein")
]
App.controller 'ScreenchatsCtrl', ['$scope', 'Screenchat', ($scope, Screenchat) ->
  $# Attributes accessible on the view
  $scope.selectedScreenchat = null
  $scope.selectedRow        = null

  # Gather the screenchats and set the selected one to the first on success
  $scope.screenchats = Screenchat.query ->
    $scope.selectedScreenchat = $scope.screenchats[0]
    $scope.selectedRow = 0

  # Set the selected screenchat to the one which was clicked
  $scope.showScreenchat = (screenchat, row) ->
    $scope.selectedScreenchat = screenchat
    $scope.selectedRow = row
]
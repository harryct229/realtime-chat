window.App = angular.module('AngularChats', ['ngResource'])

App.config ["$httpProvider", (provider) ->
  provider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")
]
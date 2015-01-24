App.directive 'sockChat', ->
  (scope, element, attrs) ->

    scope.$watch 'selectedScreenchat', (screenchat) ->
      if screenchat
        if window.socket
          window.socket.close()
          $("#output").val null

        socket = new WebSocket("ws://" + window.location.host + "/chat/" + screenchat.id)
        window.socket = socket

        data = undefined
        socket.onmessage = (event) ->
          data = jQuery.parseJSON(event.data)
          chat_line = $("<div class=\"chat_line\">").append($("<div class=\"user_info\">").text(data.username)).append($("<div class=\"chat_content\">").text(data.message).emoticonize())  if event.data.length
          $("#output").append chat_line
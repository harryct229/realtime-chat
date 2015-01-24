App.directive 'sockchat', ->
  (scope, element, attrs) ->

    scope.$watch 'selectedScreenchat', (screenchat) ->
      if screenchat
        if window.socket
          console.log("Close Socket!")
          window.socket.close()
          $(".ajax_line").remove()


        console.log("Open Socket!")
        socket = new WebSocket("ws://" + window.location.host + "/chat/" + screenchat.id)
        window.socket = socket

        data = undefined
        socket.onmessage = (event) ->
          data = jQuery.parseJSON(event.data)
          chat_line = $("<li class='ajax_line'>").append($("<div>").text(data.username + ": ")).append($("<p>").text(data.message).emoticonize())  if event.data.length
          $("#output ul").append chat_line
          $("#output").scrollTop(10000)

# Click on room
App.directive "clickchat", ->
  (scope, element, attrs) ->
    element.bind "click", ->
      $("#screenchat-list-container li h3").removeClass(attrs.clickchat)
      element.addClass(attrs.clickchat)

# Input Form chat
App.directive "formchat", ->
  (scope, element, attrs) ->
    element.bind "submit", (event)->
      $input = undefined
      event.preventDefault()
      $input = element.find("input")
      if $.trim( $input.val() ) != ''
        window.socket.send JSON.stringify(message: $input.val())
      $input.val null

# Add more room
App.directive "addroom", ->
  (scope, element, attrs) ->
    element.bind "click", ->
      $("form#new_room input").toggleClass("movein")
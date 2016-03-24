$(document).on 'ready page:load', ->
  if $('body[data-login="true"]').length
    App.room = App.cable.subscriptions.create "RoomChannel",
      connected: ->
        # Called when the subscription is ready for use on the server
        $('#messages').scrollTop(99999999);

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        # move the chat along to the newest message
        $('#messages').append(data['message']).scrollTop(9999999)

      # Print the message to chatroom when hit enter, also saves to db
      speak: (image, authorid, author, message) ->
        @perform 'speak', image: image , authorid: authorid, author: author, message: message 

      $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
        author = $('#user').val()
        authorid = $('#userid').val()
        image = $('#userimage').val()
        if event.keyCode is 13 # return = send
          App.room.speak(image,authorid,author,"#{event.target.value}")
          event.target.value = ''
          event.preventDefault()
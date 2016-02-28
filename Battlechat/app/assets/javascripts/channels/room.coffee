App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    $('#messages').scrollTop(99999999);

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#messages').append(data['message']).scrollTop(9999999)

  speak: (message) ->
    @perform 'speak', message: message 

  $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    input_user = $('#user')
    user = "Guest"
    if input_user.val() != ""
      user = input_user.val()
    if event.keyCode is 13 # return = send
      App.room.speak "#{user}: #{event.target.value}"
      event.target.value = ''
      event.preventDefault()
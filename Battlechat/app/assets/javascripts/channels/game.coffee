$(document).on 'ready page:load', ->
  if $('body[data-login="true"]').length
    console.log("active!")
    window.App.game = App.cable.subscriptions.create "GameChannel",
      connected: ->
        # Called when the subscription is ready for use on the server
        @printMessage("Waiting for opponent...")
      disconnected: ->
        # Called when the subscription has been terminated by the server
        @printMessage("Game Over")
      received: (data) ->
        # Called when there's incoming data on the websocket for this channel
        # runs when client receives a msg from channel
        switch data.action
          when "game_start"
            # App.board.position("start")
            # App.board.orientation(data.msg)
            console.log(data.msg)
            pokemon = new Pokemon()
            $('#bg_image').show()
            @printMessage("Game started! You play as #{data.msg}.")
            
          when "make_move"
            # ...
            @printMessage("move made")
          when "opponent_forfeits"
            @printMessage("Opponent forfeits. You win!")

      printMessage: (message) ->
        $("#gamestate").html("<p>#{message}</p>")

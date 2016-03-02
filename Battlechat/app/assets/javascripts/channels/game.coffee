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
            @printMessage("Game started!")
            # new game
            @pokemon = new Pokemon(data.p1,data.p2)
            console.log(data.p1) 
            console.log(data.p2) 
            console.log(@player) 
            $(document).on "click","#attack_btn", => 
              @perform 'attack', {}
            $('#bg_image').show()
            @pokemon.game_start()
            
          when "attacking"
            @pokemon.attack()
            @gameLog(data.msg)
          when "opponent_forfeits"
            @printMessage("Opponent forfeits. You win!")

      printMessage: (message) ->
        $("#gamestate").html("<p>#{message}</p>")

      gameLog: (message) ->
        $("#gamestate2").append("<p>#{message}</p>")

$(document).on 'ready page:load', ->
  if $('body[data-login="true"]').length
    console.log("active!")
    window.App.game = App.cable.subscriptions.create "GameChannel",
      connected: ->
        # Called when the subscription is ready for use on the server
        @printMessage("Waiting for opponent...")
      disconnected: ->
        # Called when the subscription has been terminated by the server
        @printMessage("Game Over!")
        $('#bg_image').hide()
        @pokemon.game_over()
      received: (data) ->
        # Called when there's incoming data on the websocket for this channel
        # runs when client receives a msg from channel
        switch data.action
          when "game_start"
            @printMessage("Battle Start!")
            # new game
            @pokemon = new Pokemon(data.p1,data.p2)
            # delegate event handlers to the document
            # when they click one of the 4 options, it hides the controls to disable multiple rapid clicks
            $(document).on "click",".attack", => 
              @perform 'attack', {}
              $(".controls").hide()
              setTimeout ->
                $(".controls").show()
              , 2500
            $(document).on "click",".heal", => 
              @perform 'heal', {}
              $(".controls").hide()
              setTimeout ->
                $(".controls").show()
              , 1200
            $(document).on "click",".charge", => 
              @perform 'charge', {}
              $(".controls").hide()
              setTimeout ->
                $(".controls").show()
              , 1800
            $(document).on "click",".taunt", => 
              @perform 'taunt', {}
              $(".controls").hide()
              setTimeout ->
                $(".controls").show()
              , 2200
            $('#bg_image').show()
            @pokemon.game_start()
          # More game logic and message logs
          when "game_over"
            $(".controls").hide()
            @gameLog(data.who+" Wins! Game Over!")
            @pokemon.game_over(data.who)

          when "hpChanged"
            @pokemon.updateHp(data.hp1, data.hp2)
            @gameLog(data.msg)

          when "shake"
            @pokemon.shake(data.msg)

          when "heal"
            @pokemon.heal(data.msg)

          when "charge"
            @pokemon.charge(data.msg)
            @gameLog(data.msg + " Charges!")

          when "atkTxt"
            @pokemon.pikaPi(data.who, data.atk)

          when "taunted"
            @pokemon.taunt(data.msg)
            @gameLog(data.msg + " Taunts!")

          when "opponent_forfeits"
            @printMessage("Opponent forfeits. You win!")

      printMessage: (message) ->
        $("#gamestate").html("<p>#{message}</p>")

      gameLog: (message) ->
        $("#gamestate2").append("<p class=\"log\">#{message}</p>").scrollTop(9999999)

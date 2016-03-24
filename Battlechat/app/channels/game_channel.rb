# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class GameChannel < ApplicationCable::Channel
  def subscribed
    @player = Player.new("player:#{uuid}")
    @game = Game.join(@player.id)
    stream_from @game.id
    if @game.players.length == 2
      @game.start(@game.users[0], @game.users[1])
      # TODO tell player which one they are, before they do an action
      # on action, it says who did what, so player should be able to figure it out.
      # if @player.id == @game.users[0]
        @game.users[0] = "Red"
      # else
        @game.users[1] = "Blue"
      # end
      # ActionCable.server.broadcast @game.id, { action: "who", msg: "You are " + @activePlayer }
    end
  end

  def unsubscribed
    if @player.current_game
      @player.leave_current_game
    end
  end

  def attack
    if @player.id == @game.users[0]
      @activePlayer = "Red"
    else
      @activePlayer = "Blue"
    end
    @player.attack()
    ActionCable.server.broadcast @game.id, { action: "shake", msg: @activePlayer }
    @game.hpChanged(@activePlayer,"clicked attack",@game.players[0].hp, @game.players[1].hp)
  end

  def heal
    if @player.id == @game.users[0]
      @activePlayer = "Red"
    else
      @activePlayer = "Blue"
    end
    @player.heal()
    ActionCable.server.broadcast @game.id, { action: "heal", msg: @activePlayer }
    @game.hpChanged(@activePlayer,"clicked heal",@game.players[0].hp, @game.players[1].hp)
  end

  def charge
    if @player.id == @game.users[0]
      @activePlayer = "Red"
    else
      @activePlayer = "Blue"
    end
    @player.charge()
    ActionCable.server.broadcast @game.id, { action: "charge", msg: @activePlayer }
  end

  def taunt
    if @player.id == @game.users[0]
      @activePlayer = "Red"
    else
      @activePlayer = "Blue"
    end
    @player.taunt()
    ActionCable.server.broadcast @game.id, { action: "taunted", msg: @activePlayer }
    ActionCable.server.broadcast @game.id, { action: "shake", msg: @activePlayer }
  end
# TODO DRY up code
  # def close()
  #   Socket.close()
  # end
end

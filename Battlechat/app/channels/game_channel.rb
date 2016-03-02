# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class GameChannel < ApplicationCable::Channel
  def subscribed
    @player = Player.new("player:#{uuid}")
    @game = Game.join(@player.id)
    stream_from @game.id
    if @game.players.length == 2
      @game.start(@game.users[0], @game.users[1])
    end
  end

  def unsubscribed
    if @player.current_game
      @player.leave_current_game
    end
  end

  def attack
    if @player.id == @game.users[0]
      activePlayer = "Red"
    else
      activePlayer = "Blue"
    end
    @player.attack(@player.opponent)
    @game.attacking(activePlayer,"clicked attack")
  end
end

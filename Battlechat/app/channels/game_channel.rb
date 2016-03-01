# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class GameChannel < ApplicationCable::Channel
  def subscribed
    @player = Player.new
    Game.join(player.id)

    stream_from player.id
  end

  def unsubscribed
    if @player.current_game
      @player.leave_current_game
    end
  end
end

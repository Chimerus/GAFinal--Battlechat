class Game
  def self.start(uuid1, uuid2)
    p1, p2 = [uuid1, uuid2].shuffle

    ActionCable.server.broadcast "player_#{p1}", {action: "game_start", msg: "p1"}
    ActionCable.server.broadcast "player_#{p2}", {action: "game_start", msg: "p2"}

    REDIS.set("opponent_for:#{p1}", p1)
    REDIS.set("opponent_for:#{p2}", p2)
  end

  def self.forfeit(uuid)
    if winner = opponent_for(uuid)
      ActionCable.server.broadcast "player_#{winner}", {action: "opponent_forfeits"}
    end
  end

  def self.opponent_for(uuid)
    REDIS.get("opponent_for:#{uuid}")
  end

  def self.make_move(uuid, data)
    opponent = opponent_for(uuid)
    move_string = "#{data["from"]}-#{data["to"]}"

    ActionCable.server.broadcast "player_#{opponent}", {action: "make_move", msg: move_string}
  end
end

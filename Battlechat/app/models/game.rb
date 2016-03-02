
class Game
  def initialize(id = "#{Game.game_prefix}#{SecureRandom.base64()}")
    @id = id
  end

  def id
    @id
  end

  def join(user_id)
    REDIS.lpush("#{@id}", user_id)
  end

  def users
    REDIS.lrange(@id, 0, 2)
  end

  def players
    users.map { |user| Player.find(user) }
  end

  def leave(user_id)
    players = REDIS.lrange(@id, 0, 2).reject do |id|
      id == user_id
    end

    REDIS.del(@id)
    players.each do |player_id|
      REDIS.lpush(@id, player_id)
    end
    return nil
  end

  def self.find(id)
    Game.new(id)
  end

  def self.game_prefix
    'game:'
  end

  def self.available_game
    all_games = REDIS.keys("#{self.game_prefix}*")
    all_games.each do |game_id|
      if REDIS.llen(game_id) < 2
        return Game.new(game_id)
      end
    end
    return nil 
  end

  def self.join(user_id)
    av_game = self.available_game
    if av_game
      av_game.join(user_id)
      # 2 people here, start the game!
      return av_game
    else
      game = Game.new
      game.join(user_id)
      return game
    end
  end

  def start(player1, player2)
    binding.pry
    ActionCable.server.broadcast @id, { action: "game_start", msg: "this works" }

    REDIS.set("opponent_for:#{player1.id}", player1.id)
    REDIS.set("opponent_for:#{player2.id}", player2.id)
  end

  def self.forfeit(uuid)
    if winner = opponent_for(uuid)
      #ActionCable.server.broadcast "#{}", {action: "opponent_forfeits"}
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

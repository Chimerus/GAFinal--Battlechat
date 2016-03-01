class Player
  def initialize(id="#{Player.player_prefix}#{SecureRandom.base64()}")
    @id = id
  end

  def id
    @id
  end

  def leave_current_game
    current_game.leave(@id)
  end

  def opponent
    temp = current_game.users.reject do |id|
      id == @id
    end
    player_id = temp[0]
    if player_id != nil
      return Player.find(player_id)
    end
    return nil
  end

  def current_game
    all_games = REDIS.keys('game:*')
    all_games.each do |game|
      game = Game.find(game)
      players = game.users.reject { |player_id| player_id != @id }
      if players.length > 0
        return game
      end
    end
    return nil
  end

  def self.player_prefix
    'player:'
  end

  def self.find(id)
    Player.new(id)
  end
end
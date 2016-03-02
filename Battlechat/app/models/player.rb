class Player
  def initialize(id="#{Player.player_prefix}#{SecureRandom.uuid}")
    @id = id
    @hp = 100
    @attackPower = 10
  end

    attr_accessor :hp, :attackPower

  def connection_id
    @id.gsub(Player.player_prefix, '')
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

  def attack(opponent)
    binding.pry
    @opponent.hp -= @attackPower
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
    # Player.new(id)
    Player.find(id)
  end
end
class Player
  def initialize(id="#{Player.player_prefix}#{SecureRandom.uuid}", start_hp=100, start_atk=10)
    @id = id
    hp((hp == nil) ? start_hp : hp)
    atk((atk == nil) ? start_atk : atk)
  end

  def attribute(key, val = nil)
    if val != nil
      REDIS.set("#{id}:#{key}", val)
    end
    REDIS.get("#{id}:#{key}")
  end

  def hp(val = nil)
    res = attribute('hp', val)
    if res != nil
      res.to_f
    else
      nil
    end
  end

  def atk(val = nil)
    res = attribute('atk', val)
    if res != nil
      res.to_f
    else
      nil
    end
  end

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

  def attack()
    opponent.hp(opponent.hp-atk)
    if @id == current_game.users[0]
      activePlayer = "Red"
    else
      activePlayer = "Blue"
    end
    ActionCable.server.broadcast current_game.id, { action: "atkTxt", who: activePlayer, atk: atk}
    if opponent.hp() <= 0
      ActionCable.server.broadcast current_game.id, { action: "game_over", who: activePlayer}
    end
    return nil
  end

  def charge()
    self.atk(self.atk+5)
    return nil
  end

  def heal()
    if(self.hp < 100)
      if(self.hp > 93)
        self.hp(100)
      end
      self.hp(self.hp+7)
    else
      self.hp(100)
    end
    return nil
  end

  def taunt()
    opponent.atk(opponent.atk-5)
    if @id == current_game.users[0]
      activePlayer = "Red"
    else
      activePlayer = "Blue"
    end
    ActionCable.server.broadcast current_game.id, { action: "taunted", who: activePlayer}
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
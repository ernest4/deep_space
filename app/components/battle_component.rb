class BattleComponent < ApplicationComponent
  def initialize(battle_id:)
    @battle = Battle.find(battle_id)
    @opponent = @battle.characters.where.not(:id => Current.character.id)
  end

  def call
    div do
      # c UI::CardComponent.new(:body => "BATTLE WIP !!!")
      c ships
    end
  end

  private

  def ships
    div(:class => "flex justify between") do
      c ships_for(Current.character)
      c ships_for(@opponent)
    end
  end

  def ships_for(character)
    div do
      # character.active_battle_set_ships.each do |ship|
      #   c draw_ship(ship)
      # end

      # character.active_battle_set_ships.each do |ship|
        c draw_ship(character.active_battle_set_ships.first)
      # end
    end
  end

  def draw_ship(ship)
    div do
      # send("draw_#{ship.category}_ship", ship)
      return draw_small_ship(ship) if ship.category == "small"
      return draw_medium_ship(ship) if ship.category == "medium"
      return draw_large_ship(ship) if ship.category == "large"
    end
  end

  def draw_small_ship(_ship)
    div(:class => "w-1 h-1 bg-green-500")
  end

  def draw_medium_ship(_ship)
    div(:class => "w-2 h-2 bg-blue-500")
  end

  def draw_large_ship(_ship)
    div(:class => "w-3 h-3 bg-yellow-500")
  end
end

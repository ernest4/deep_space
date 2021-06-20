class BattleComponent < ApplicationComponent
  def initialize(battle_id:)
    @battle = Battle.find(battle_id)
    @opponent = @battle.characters.where.not(:id => Current.character.id).first
  end

  def call
    div(:class => "w-full") do
      # c UI::CardComponent.new(:body => "BATTLE WIP !!!")
      c ships
    end
  end

  private

  def ships
    div(:class => "flex justify between w-full") do
      c ships_for(Current.character)
      c ships_for(@opponent, :right => true)
    end
  end

  def ships_for(character, right: nil)
    div(:class => "flex flex-col justify-between w-full #{right.presence && 'items-end'}") do
      character.active_battle_set_ships.each do |ship|
        c draw_ship(ship)
        c div(:class => "pt-4")
      end
    end
  end

  def draw_ship(ship)
    # div do
    # send("draw_#{ship.category}_ship", ship)
    return draw_small_ship(ship) if ship.category == "small"
    return draw_medium_ship(ship) if ship.category == "medium"
    return draw_large_ship(ship) if ship.category == "large"
    # end
  end

  def draw_small_ship(_ship)
    div(:class => "w-10 h-4 bg-green-500")
  end

  def draw_medium_ship(_ship)
    div(:class => "w-20 h-8 bg-blue-500")
  end

  def draw_large_ship(_ship)
    div(:class => "w-40 h-16 bg-yellow-500")
  end
end

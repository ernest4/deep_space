# TODO: specs
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
        c div(:class => "pt-8")
      end
    end
  end

  # TODO: probs extract this into a component that will be further managed by stimulus
  # that will use attributes to access and (re)render various bits as needed
  def draw_ship(ship)
    div(:class => "hover:border-primary border-2 rounded border-transparent cursor-pointer w-max p-1") do
      c draw_ship_stats(ship)
      c div(:class => "pt-1")
      c send("draw_#{ship.category}_ship", ship)
    # return draw_small_ship(ship) if ship.category == "small"
    # return draw_medium_ship(ship) if ship.category == "medium"
    # return draw_large_ship(ship) if ship.category == "large"
    end
  end

  def draw_ship_stats(ship)
    # div("H #{ship.hitpoints} A #{ship.armourpoints}" S #{ship.shieldpoints} X #{ship.xp} L #{ship.level}")
    div("H #{ship.hitpoints}", :class => "g-text-primary text-xs")
  end

  def draw_small_ship(ship)
    div(:class => "w-10 h-4 bg-green-500", :id => ship_id(ship))
  end

  def draw_medium_ship(ship)
    div(:class => "w-20 h-8 bg-blue-500", :id => ship_id(ship))
  end

  def draw_large_ship(ship)
    div(:class => "w-40 h-16 bg-yellow-500", :id => ship_id(ship))
  end

  def ship_id(ship)
    "ship_#{ship.id}"
  end
end

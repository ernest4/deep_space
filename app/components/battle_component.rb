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
      c ships_for(Current.character, "player")
      c ships_for(@opponent, "opponent")
    end
  end

  def ships_for(character, owner)
    div(:class => "flex flex-col justify-between w-full #{opponent?(owner) && 'items-end'}") do
      character.active_battle_set_ships.each do |ship|
        c draw_ship(ship, owner)
        c div(:class => "pt-8")
      end
    end
  end

  def opponent?(owner)
    owner == "opponent"
  end

  # TODO: probs extract this into a component that will be further managed by stimulus
  # that will use attributes to access and (re)render various bits as needed
  def draw_ship(ship, owner)
    # div(:class => "hover:border-primary border-2 rounded border-transparent cursor-pointer w-max p-1") do
    #   c draw_ship_stats(ship)
    #   c div(:class => "pt-1")
    #   c send("draw_#{ship.category}_ship", ship)
    # # return draw_small_ship(ship) if ship.category == "small"
    # # return draw_medium_ship(ship) if ship.category == "medium"
    # # return draw_large_ship(ship) if ship.category == "large"
    # end
    right_align_style = "items-end flex flex-col" if opponent?(owner)
    UI::Button::ModalComponent.new(
      :button => div(:class => "hover:border-primary border-2 rounded border-transparent cursor-pointer w-max p-1 #{right_align_style}") do
        c draw_ship_stats(ship)
        c div(:class => "pt-1")
        c send("draw_#{ship.category}_ship", ship)
        c div(:class => "pt-1")
        c draw_ship_name(ship, owner)
        # return draw_small_ship(ship) if ship.category == "small"
        # return draw_medium_ship(ship) if ship.category == "medium"
        # return draw_large_ship(ship) if ship.category == "large"
      end,
      :modal => div do
        c div(:class => "g-text") {
          c ship_sub_commander(ship, owner)
          c div(:class => "pt-2")
          c ship_description(ship, owner)
          unless opponent?(owner)
            c div(:class => "pt-2")
            c ship_actions(ship, owner)
          end
        }
      end
    )
  end

  def ship_sub_commander(ship, owner)
    UI::CardComponent.new(
      :danger => opponent?(owner),
      :header => "Sub-Commander",
      :body => "Commander Feature Coming Soon"
    )
  end

  def ship_description(ship, owner)
    UI::CardComponent.new(
      :danger => opponent?(owner),
      :header => capitalize_each_word(ship.name),
      :body => div(:class => "") do
        c send("draw_#{ship.category}_ship", ship)
        c div(:class => "pt-1")
        # TODO: stats with bar for each
        c draw_ship_stats(ship)
        c div(:class => "pt-1")
        # c "description" # TODO: wip some kinda dynamic description of it's, battles it has survived, veterancy etc
        # c "level etc"
      end
    )
  end

  def ship_actions(ship, owner)
    # TODO: special extra actions depending on ship configuration
    UI::CardComponent.new(
      :danger => opponent?(owner),
      :header => "Actions",
      :body => div(:class => "flex justify-between") do
        # TODO: really need hover now to show what it will do and AC (Action Point Cost) ?
        c div("Attack", :class => "g-button-secondary g-button-small")
        c div("Defend", :class => "g-button-secondary g-button-small")
        c div("Move", :class => "g-button-secondary g-button-small")
      end
    )
  end

  def draw_ship_stats(ship)
    # div("H #{ship.hitpoints} A #{ship.armourpoints}" S #{ship.shieldpoints} X #{ship.xp} L #{ship.level}")
    div("H #{ship.hitpoints}", :class => "g-text-primary text-xs")
  end

  def draw_ship_name(ship, owner)
    name_color = opponent?(owner) ? "red" : "blue" 
    div(:class => "g-text italic text-#{name_color}-400 text-xs") do
      c capitalize_each_word(ship.name)
    end
  end

  def capitalize_each_word(string)
    string.split(" ").map(&:capitalize).join(" ")
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

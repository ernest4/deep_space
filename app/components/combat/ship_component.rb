# TODO: specs

module Combat
  class ShipComponent < ApplicationComponent
    include Motion::Component

    def initialize(battle_id:, ship_data:, opponent:)
      @battle_id = battle_id
      @ship = OpenStruct.new(ship_data)
      @opponent = opponent
    end

    def opponent?
      @opponent
    end

    map_motion :click

    def click
      ActionCable.server.broadcast(
        "battle:#{@battle_id}:ship:select",
        { :ship => @ship.to_h, :opponent => @opponent }
      )
    end

    def call
      right_align_style = "items-end flex flex-col" if opponent?

      div(:data => { :motion => :click }, :class => "hover:border-primary border-2 rounded border-transparent cursor-pointer w-max p-1 #{right_align_style}") do
        c draw_ship_stats(@ship)
        c div(:class => "pt-1")
        c send("draw_#{@ship.category}_ship", @ship)
        c div(:class => "pt-1")
        c draw_ship_name(@ship)
      end
    end

    def draw_ship_stats(ship)
      # div("H #{ship.hitpoints} A #{ship.armourpoints}" S #{ship.shieldpoints} X #{ship.xp} L #{ship.level}")
      div("H #{ship.hitpoints}", :class => "g-text-primary text-xs")
    end

    def draw_ship_name(ship)
      name_color = opponent? ? "red" : "blue"
      div(:class => "g-text italic text-#{name_color}-400 text-xs") do
        c capitalize_each_word(ship.name)
      end
    end

    # TODO: extract to util lib
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
end

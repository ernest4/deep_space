# TODO: specs

module Combat
  class FooterComponent < ApplicationComponent
    include Motion::Component

    def initialize(battle_id:)
      @battle_id = battle_id
      @ship = nil
      @character_id = Current.character.id

      # NOTE: need to call this here to have access to instance variables!!!
      stream_from "battle:#{battle_id}:character:#{@character_id}:ship:select", :ship_select
    end

    map_motion :close

    def close
      @ship = nil
    end

    def ship_select(data)
      @ship = OpenStruct.new(data["ship"]) # x4 ~ x5 less marshalled data than using actual ActiveRecord model
      @opponent = data["opponent"]
    end

    def call
      return div if @ship.blank?

      div(:class => "fixed w-full bottom-0 left-0") do
        c div(:class => "g-text grid grid-cols-3") {
          c ship_sub_commander(@ship, @opponent)
          c ship_description(@ship, @opponent)
          c ship_actions(@ship) unless @opponent
        }
        c div(:class => "pt-4")
      end
    end

    def ship_sub_commander(_ship, opponent)
      UI::CardComponent.new(
        :style => "bg-gray-700 bg-opacity-80",
        :danger => opponent,
        :header => "Sub-Commander",
        :body => "Commander Feature Coming Soon"
      )
    end

    def ship_description(ship, opponent)
      UI::CardComponent.new(
        :style => "bg-gray-700 bg-opacity-80",
        :danger => opponent,
        :header => capitalize_each_word(ship.name),
        :body => div(:class => "") do
          c Combat::Ship::GraphicComponent.new(:ship => ship)
          c div(:class => "pt-1")
          # TODO: stats with bar for each
          c draw_ship_stats(ship)
          c div(:class => "pt-1")
          # c "description" # TODO: wip some kinda dynamic description of it's, battles it has survived, veterancy etc
          # c "level etc"
        end
      )
    end

    # TODO: extract to helper lib
    def capitalize_each_word(string)
      string.split(" ").map(&:capitalize).join(" ")
    end

    def draw_ship_stats(ship)
      # div("H #{ship.hitpoints} A #{ship.armourpoints}" S #{ship.shieldpoints} X #{ship.xp} L #{ship.level}")
      div("H #{ship.hitpoints}", :class => "g-text-primary text-xs")
    end

    def ship_actions(_ship)
      # TODO: special extra actions depending on ship configuration
      UI::CardComponent.new(
        :style => "bg-gray-700 bg-opacity-80",
        :header => "Your orders Commander?",
        :body => div(:class => "grid grid-cols-3 gap-1") do
          # TODO: really need hover now to show what it will do and AC (Action Point Cost) ?
          c UI::HoverComponent.new(
            :trigger => div("Attack", :class => "g-button-secondary g-button-small text-center"),
            :hover => UI::CardComponent.new(
              :style => "bg-gray-700 bg-opacity-90",
              :body => div do
                "Attack hover testing"
              end
            )
          )
          c div("Defend", :class => "g-button-secondary g-button-small text-center")
          c div("Move", :class => "g-button-secondary g-button-small text-center")
          c div
          c div
          c div
          c div
          c div
          c div("Close", :class => "g-button-danger g-button-small text-center", :data => { :motion => :close })
        end
      )
    end
  end
end

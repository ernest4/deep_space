# TODO: specs

module Combat
  class FooterComponent < ApplicationComponent
    include Motion::Component

    def initialize(battle_id:)
      @battle_id = battle_id
      @ship_data = nil
    end

    # TODO: namespace by character so the right character receives the change !!!
    stream_from "battle:#{@battle_id}:ship:select", :ship_select

    def ship_select(data)
      @ship_data = data["ship"]
      @opponent = data["opponent"]
    end

    def call
      return div if @ship_data.blank?

      div(:class => "fixed w-full bottom-0") do
        c div(:class => "g-text flex justify-between") {
          # c ship_sub_commander(ship, owner)
          # c div(:class => "pt-2")
          # c ship_description(ship, owner)
          # unless opponent?(owner)
          #   c div(:class => "pt-2")
          #   c ship_actions(ship, owner)
          # end
          c @ship_data.to_s
        }
        c div(:class => "pt-4")
      end
    end

    def ship_sub_commander(_ship, owner)
      UI::CardComponent.new(
        :danger => opponent?(owner),
        :header => "Sub-Commander",
        :body => "Commander Feature Coming Soon"
      )
    end

    def opponent?(owner)
      owner == "opponent"
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

    def capitalize_each_word(string)
      string.split(" ").map(&:capitalize).join(" ")
    end

    def ship_actions(_ship, owner)
      # TODO: special extra actions depending on ship configuration
      UI::CardComponent.new(
        :danger => opponent?(owner),
        :header => "Your orders Commander?",
        :body => div(:class => "flex justify-between") do
          # TODO: really need hover now to show what it will do and AC (Action Point Cost) ?
          c UI::HoverComponent.new(
            :trigger => div("Attack", :class => "g-button-secondary g-button-small"),
            :hover => UI::CardComponent.new(
              :body => "Attack hover testing"
            )
          )
          c div("Defend", :class => "g-button-secondary g-button-small")
          c div("Move", :class => "g-button-secondary g-button-small")
        end
      )
    end
  end
end

# frozen_string_literal: true

class HomeComponent < ApplicationComponent
  def initialize(user_counts:)
    @user_counts = user_counts
  end

  def call
    capture do
      c div(:class => "pt-2 bg-blue-500")
      c div(:class => "pt-4")
      c jumbotron
      c div(:class => "pt-4")
      c player_counts(@user_counts)
      c div(:class => "pt-4")
      c features
    end
  end

  private

  def jumbotron
    UI::CardComponent.new(
      :header => "About",
      :body => div do
        c span("Deep Space (DS)", :class => "ds-text-primary")
        c " is a text based MMORPG set in Milky Way Galaxy. You are the "
        c span("commander", :class => "ds-text-secondary")
        c " of your fleet of "
        c span("ships", :class => "ds-text-tertiary")
        c " and colonizer of "
        c span("planets", :class => "ds-text-tertiary")
        c "."
        c br
        c br
        c "Build yourself and your galactic empire your way with other "
        c span("players", :class => "ds-text-secondary")
        c " around the world. Form "
        c span("alliances", :class => "ds-text-tertiary")
        c ", "
        c span("trade", :class => "ds-text-tertiary")
        c ", "
        c span("fight", :class => "ds-text-tertiary")
        c " and "
        c span("discover", :class => "ds-text-tertiary")
        c " the mysteries of deep dark space."
        c br
        c br
        c "Lead the way, commander!" # TODO: make this a button.
      end
    )
  end

  def player_counts(user_counts)
    UI::CardComponent.new(
      :header => "Players Online",
      :body => div(:class => "flex justify-between") do
        user_counts.each_with_index do |user_count, index|
          type, count = user_count

          c span {
            c span(type.to_s.split("_").join(" "), :class => "ds-text-secondary")
            c " : "
            c span(count, :class => "sv-text font-bold")
          }

          next if index == user_counts.size - 1

          c div(:class => "flex") {
            c UI::LineComponent.new(:vertical => true)
            c span(:class => "pr-2")
          }
        end
      end,
      :footer => span("The game is in early stages of development. Why not invite your friends to play together?")
    )
  end

  def features
    feature_lists = {
      :available => {
        :subtitle => "Subject to improvements / expansions ",
        :features => [
          { :title => "Gratis", :description => "Deep Space is and always will be free to play." },
          { :title => "Single Universe", :description => "A single database (shard) means all
          players share the same game, no artificial segregation of populations." },
          { :title => "Galaxy Map", :description => "Explore the shared galaxy with interstellar travel." },
          { :title => "Combat", :description => "Engage your fleets against those of other players
          to win control of stars and planets." },
          { :title => "Conquest", :description => "Gain control of locations like planets, stars,
           asteroids etc. to expand your galactic empire. Each player owns a controlling share of
           any given location. Fight more to control more." },
          { :title => "Construction", :description => "Build resource extractors and infrastructure
          to get more resources. Use resources to supply and enlarge your fleets." },
          { :title => "Trade Routes", :description => "Set up trade routes to move goods around your
          empire." },
          { :title => "Rogue-lite", :description => "Fleet combat is turn based, destroyed ships are
          permanently lost, decisions carry consequences, all resources in possession are finite and
          continuously consumed, location control can be gained and lost etc." },
          { :title => "Menacing Machines", :description => "These rogue robots of unknown origin
          and unknown purpose are widespread throughout the galaxy. They seem to attack any organic
          life on sight. Fight them when you can...run when you have to..." },
        ]
      },
      :planned => {
        :subtitle => "Subject to changes, in no particular order",
        :features => [
          { :title => "Missions", :description => "Respond to distress beacons, seek hidden
          artifacts of the Ancient Ones, fight the Menacing Machines and solve the biggest
          mysteries at the centre of the galaxy." },
          { :title => "Research", :description => "Research tech tree allows you improve everything
          and anything." },
          { :title => "Player Trade", :description => "Trade everything, resources, ships, planets etc." },
          { :title => "Companies", :description => "Players can form companies, have other players
          as employees and list shares on stock exchange." },
          { :title => "Stock Market", :description => "Players can buy / sell shares of other
          players' companies." },
          { :title => "Alliances", :description => "Create or join an alliance of players to
          socialize, share resources and battle other alliances." },
          { :title => "Field Commander", :description => "You as the commander can join the
          battlefield. Like a king in Chess, fatal destruction of a commander's vessel means
          immediate loss. Additional penalty is that the commander is blasted into space in a cryo escape pod, waiting to be rescued by the search party. This imposes a cooldown, before commander can be retrieved. Other players may send a search party to rescue and speed things up. commanders presence on battlefield boosts stats of commanders ships. commander can be on board any ship during battle, but cannot change ships mid battle. If commander's vessel leaves combat, ships receive a penalty to their stats (morale drop)." },
          { :title => "feature two", :description => "lorem ipsum" },
        ]
      }
    }
    UI::CardComponent.new(
      :header => span("Features", :class => "font-bold"),
      :body => div do
        feature_lists.each do |feature_list_name, feature_list|
          c span(feature_list_name.capitalize, :class => "sv-text font-bold")
          if feature_list[:subtitle].present?
            c div(feature_list[:subtitle], :class => "ds-text italic text-gray-400 text-sm")
          end

          c div(:class => "pt-2")
          feature_list[:features].each do |feature|
            c div(:class => "pt-2")
            c div(feature[:title], :class => "ds-text-secondary")
            c div(feature[:description], :class => "ds-text text-sm")
          end
          c div(:class => "pt-8")
        end
      end
    )
  end
end

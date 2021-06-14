# frozen_string_literal: true

class HomeComponent < ApplicationComponent
  def initialize(user_counts:)
    @user_counts = user_counts
  end

  def call
    capture do
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
        c span("#{Constants::GAME_NAME} (#{Constants::GAME_NAME_ACRONYM})", :class => "g-text-primary")
        c " is a text based MMORPG set in Milky Way Galaxy. You are the "
        c span("commander", :class => "g-text-secondary")
        c " of your fleet of "
        c span("ships", :class => "g-text-tertiary")
        c " and colonizer of "
        c span("planets", :class => "g-text-tertiary")
        c "."
        c br
        c br
        c "Build yourself and your galactic empire your way with other "
        c span("players", :class => "g-text-secondary")
        c " around the world. Form "
        c span("alliances", :class => "g-text-tertiary")
        c ", "
        c span("trade", :class => "g-text-tertiary")
        c ", "
        c span("fight", :class => "g-text-tertiary")
        c " and "
        c span("discover", :class => "g-text-tertiary")
        c " the mysteries of deep dark space."
        c br
        c br
        c "Lead the way, commander!"
        c div(:class => "pt-2")
        c GoogleSignInButtonComponent.new
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
            c span(type.to_s.split("_").join(" "), :class => "g-text-secondary")
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
          { :title => "Gratis", :description => "#{Constants::GAME_NAME} is and always will be free to play." },
          { :title => "Single Universe", :description => "A single database (shard) means all
          players share the same game, no artificial segregation of populations." },
          { :title => "Influence Development", :description => div do
            c "Join "
            c link_to(nil, "Discord", :href => "https://discord.gg/4QXZw5Xvz5", :class => "g-link-tertiary text-sm", :target => "_blank", :rel => "noopener")
            c " chat to track development, report bugs and make feature requests."
          end },
          { :title => "Commander", :description => "You are the commander. Level up and command
           bigger more powerful fleets." },
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
          { :title => "Menacing Machines", :description => "Fight against the rogue AI robots out to
           destroy all organics for reasons not yet known." }
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
          battlefield to boost your fleet's stats. Like a king in Chess, fatal destruction of
          commander's vessel means immediate loss of the battle." },
          { :title => "Sub-Commanders", :description => "Each ship has a distinct NPC sub-commander
          with RNG stats and unique personality and expertise. Hire, Fire & Retire sub-commanders." },
          { :title => "Group PVP", :description => "Players can PVP in groups of two or more.
          PVP does not need to be symmetric, two or more players can fight against one opponent.
          The ship strength will be matched however, meaning side with more players brings less
          ships per player." },
          { :title => "Reinforcements", :description => "Ships from nearby friendly areas can be
          warped in. Warp in will take number of turns and once at the battlefield, players will
          need to swap out existing ship(s)." },
          { :title => "Experimental Tech ", :description => "Research and develop experimental
          technology that has a chance of blowing up in your face in the worst case and blowing away
           your opponent in the best case." },
          { :title => "Treasure Hunt", :description => "Space pirates haven't evolved that much,
          they still like to hide their treasure in random places to be forgotten and rediscovered." },
          { :title => "Prestige", :description => "Prestige starts a new play-through after reaching
           the centre of Galaxy. Earn rewards that persist through Prestiges." },
          { :title => "Space Racers", :description => "Develop a Space Racing. Recruit and train
           your racers and supporting team. Enter into competitions for prizes in racing
           tournaments. Spectate and bet on races." },
          { :title => "Milky Millions", :description => "Play in-game lottery. A winner is
          guaranteed every month." },
          { :title => "The Void", :description => "Catch up on Galaxy wide news, on the in game
          newspaper 'The Void'." }
        ]
      }
    }
    UI::CardComponent.new(
      :header => span("Features", :class => "font-bold"),
      :body => div do
        feature_lists.each do |feature_list_name, feature_list|
          c span(feature_list_name.capitalize, :class => "sv-text font-bold")
          if feature_list[:subtitle].present?
            c div(feature_list[:subtitle], :class => "g-text italic text-gray-400 text-sm")
          end

          c div(:class => "pt-2")
          feature_list[:features].each do |feature|
            c div(:class => "pt-2")
            c div(feature[:title], :class => "g-text-secondary")
            c div(feature[:description], :class => "g-text text-sm")
          end
          c div(:class => "pt-8")
        end
      end
    )
  end
end

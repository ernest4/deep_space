class GalaxyComponent < ApplicationComponent
  def call
    footer_nav
    capture do
      # c "new user tutorial? wip"
      c div(:class => "pt-4")
      # c UI::CardComponent.new(:body => locations)
      c locations

      # TESTING
      c locations
      c locations
      c locations
    end
  end

  def locations
    div do
      Current.character.occupations.each do |occupation|
        c UI::CardComponent.new(
          :header => occupation.occupiable.name,
          :body => div do
            c div(:class => "pt-4")
            c div(:class => "md:flex") {
              c div(:class => "rounded-full bg-white w-48 h-48")
              c div(:class => "pt-4 md:pt-0")
              c span("The starting location and safe haven for all new explorers.")
            }
            c div(:class => "pt-4")
          end,
          :footer => "#{occupation.occupiable_type} #{occupation.occupiable.position.to_coords.values}"
        )
      end
    end
  end

  def footer_nav
    content_for :footer do
      c div(:class => "fixed w-full bottom-0") {
        if Current.character.seeking_battle?
          c div(:class => "flex flex-col items-center w-max mx-auto") {
            c UI::CardComponent.new(:primary => true, :body => "Looking For Opponents...")
            c div(:class => "pt-2")
            c link_to("Cancel", matchmaking_cancel_path, :class => "g-button-secondary h-full w-full text-center")
          }
        else
          c div(:class => "flex justify-center items-end") {
              c UI::Button::ModalComponent.new(
                :button => div("Quick Battle", :class => "g-button-primary g-button-large h-full"),
                :modal => UI::CardComponent.new(
                  :header => "Quick Battle",
                  :body => div do
                    c pvp
                    c div(:class => "pt-4")
                    c pve
                  end
                )
              )
              c div(:class => "rounded-full bg-white w-48 h-48 border-secondary border-8")
              c UI::Button::ModalComponent.new(
                :button => div("Group Battle", :class => "g-button-secondary g-button-large h-full"),
                :modal => UI::CardComponent.new(
                  :header => "Coming Soon",
                  :body => "Work In Progress"
                )
              )
            }
        end
        c div(:class => "pt-4")
      }
    end
  end

  def pvp
    div(:class => "") do
      # c UI::Button::ModalComponent.new(
      #   :button => div("Player vs Player", :class => "g-button-primary g-button-large h-full"),
      #   :modal => "wip"
      # )
      c form_with(:url => matchmaking_create_path, :local => true) { |form|
        c form.submit("Player vs Player", :data => { :disable_with => "Looking For Opponents..." }, :class => "g-button-primary g-button-large h-full w-full")
      }
      c span("Look for an opponent online!")
    end
  end

  def pve
    div(:class => "") do
      c UI::Button::ModalComponent.new(
        :button => div("Player vs Enemy", :class => "g-button-secondary g-button-large h-full"),
        :modal => UI::CardComponent.new(:body => "Coming soon")
      )
      c span("Fight the Menacing Machines!")
    end
  end
end

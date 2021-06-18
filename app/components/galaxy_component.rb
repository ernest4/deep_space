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
        c div(:class => "flex justify-center items-end") {
            c UI::Button::ModalComponent.new(
              :button => div("Quick Battle", :class => "g-button-primary g-button-large h-full"),
              :modal => UI::CardComponent.new(
                :header => "Quick Battle [header test]",
                :body => div do
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                  c "testing quick battle modal body"
                end,
                :footer => "testing quick battle modal footer"
              )
            )
            c div(:class => "rounded-full bg-white w-48 h-48 border-secondary border-8")
            # TODO: hover for "coming soon"
            # c div("Group Battle", :class => "g-button-secondary g-button-large h-full")
            c UI::Button::ModalComponent.new(
              :button => div("Group Battle", :class => "g-button-secondary g-button-large h-full"),
              :modal => UI::CardComponent.new(
                :header => "Coming Soon",
                :body => "Work In Progress"
              )
            )
          }
        c div(:class => "pt-4")
      }
    end
  end
end

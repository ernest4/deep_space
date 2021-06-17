class GalaxyComponent < ApplicationComponent
  def call
    capture do
      # c "new user tutorial? wip"
      c div(:class => "flex justify-between") {
        c div("Quick Battle", :class => "g-button-primary g-button-large")
        # TODO: hover for "coming soon"
        c div("Group Battle", :class => "g-button-secondary g-button-large")
      }
      c div(:class => "pt-4")
      c UI::CardComponent.new(:body => locations)
    end
  end

  def locations
    div do
      Current.character.occupations.each do |occupation|
        c UI::CardComponent.new(
          :header => occupation.occupiable.name,
          :body => div(:class => "rounded-full bg-white w-16 h-16"),
          :footer => "#{occupation.occupiable_type} | #{occupation.occupiable.position.to_coords}"
        )
      end
    end
  end
end

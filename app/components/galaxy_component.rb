class GalaxyComponent < ApplicationComponent
  def call
    capture do
      c "new user tutorial? wip"
      c Galaxy::MapComponent.new(:center => Current.character.position.to_coords)
    end
  end
end

# TODO: specs
class BattleComponent < ApplicationComponent
  def initialize(battle_id:)
    @battle = Battle.find(battle_id)
    @opponent = @battle.characters.where.not(:id => Current.character.id).first
  end

  def call
    div(:class => "w-full") do
      # c TestyMotionComponent.new
      c Combat::HeaderComponent.new
      c ships
      c div(:class => "pt-96")
      c Combat::FooterComponent.new(:battle_id => @battle.id)
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
        c Combat::Ship::ContainerComponent.new(
          :battle_id => @battle.id,
          :ship_data => ship.attributes,
          :opponent => opponent?(owner)
        )
        c div(:class => "pt-8")
      end
    end
  end

  def opponent?(owner)
    owner == "opponent"
  end
end

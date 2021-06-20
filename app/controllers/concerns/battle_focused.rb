module BattleFocused
  extend ActiveSupport::Concern

  # included do
  #   before_action :redirect_to_active_battle
  # end

  # private

  # TODO: make sure this is applied everywhere appropriate
  def redirect_to_active_battle
    return unless Current.character&.battling?

    battle = Current.character.battles.live.first
    redirect_to battle_path(battle)
  end
end

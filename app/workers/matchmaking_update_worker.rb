class MatchmakingUpdateWorker
  include Sidekiq::Worker

  def perform(battle_id)
    battle = Battle.find(battle_id)
    return MatchmakingUpdateWorker.perform_in(3.seconds, battle_id) unless battle.full?

    # battle.start!
    BattleStartWorker.perform_async(battle_id)
  end
end

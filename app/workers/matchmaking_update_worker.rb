class MatchmakingUpdateWorker
  include Sidekiq::Worker

  def perform(battle_id)
    battle = Battle.find(battle_id)
    return battle.start! if battle.full?

    MatchmakingUpdateWorker.perform_in(3.seconds, battle_id)
  end
end

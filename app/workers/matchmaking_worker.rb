class MatchmakingWorker
  include Sidekiq::Worker

  def perform(character_id)
    character = Character.find(character_id)
    return unless character.seeking_battle?

    # TODO: ... wip...
    # go thorugh open battles,
    # pick oldest waiting one
    # [later] apply ELO & ranking

    # create battle if doesnt exist and exit here
    # [later] in group battle, will AC notify player join count

    # AC broadcast to all parties in the battle once ready
  end
end

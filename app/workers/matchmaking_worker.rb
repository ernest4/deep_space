class MatchmakingWorker
  include Sidekiq::Worker

  def perform(character_id)
    character = Character.find(character_id)

    battles = Battle.duel.waiting.order(:created_at => :asc) # oldest to newest

    battles.find_each do |battle|
      break unless character.seeking_battle?

      battle.with_lock do # The block is called within transaction, battle is already locked.
        next unless battle.waiting? # check again after locking in case too late

        # TODO: [later] apply ELO & ranking
        battle.add_participant!(character)
        character.update!(:state => "waiting_battle")
        MatchmakingUpdateWorker.perform_in(3.seconds, battle.id)
      end
    end

    return unless character.seeking_battle?

    # didn't find any existing battles, create a new one

    battle = nil
    ActiveRecord::Base.transaction do
      battle = Battle.new(:player_limit => 2, :state => "waiting")
      battle.add_participant!(character)
      character.update!(:state => "waiting_battle")
    end

    # TODO: [later] in group battle, will AC notify player join count
    # TODO: AC broadcast to all parties in the battle once ready
    MatchmakingUpdateWorker.perform_in(3.seconds, battle.id) if battle.present?
  end
end

class MatchmakingWorker
  include Sidekiq::Worker

  def perform(character_id)
    character = Character.find(character_id)

    suitable_battles = Battle.duel.waiting.order(:created_at => :asc) # oldest to newest

    suitable_battles.find_each do |suitable_battle|
      break unless character.seeking_battle?

      suitable_battle.with_lock do # The block is called within transaction, battle is already locked.
        next unless candidate_battle.waiting? # check again after locking in case too late

        # TODO: [later] apply ELO & ranking
        candidate_battle.add_participant!(character)
        character.update!(:status => "waiting_battle")
      end
    end

    return unless character.seeking_battle?

    # didn't find any existing battles, create a new one

    ActiveRecord::Base.transaction do
      battle = Battle.new(:player_limit => 2, :state => "waiting")
      battle.add_participant!(character)
      character.update!(:status => "waiting_battle")
    end

    # TODO: [later] in group battle, will AC notify player join count
    # TODO: AC broadcast to all parties in the battle once ready
  end
end

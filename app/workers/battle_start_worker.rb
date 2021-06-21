class BattleStartWorker
  include Sidekiq::Worker

  def perform(battle_id)
    battle = Battle.find(battle_id)
    return if battle.live?

    ActiveRecord::Base.transaction do
      battle.update!(:state => "live")
      battle.characters.each { |character| character.update!(:state => "battling") }
    end
    # ActionCable.server.broadcast("battle_#{battle.id}_user_#{user.id}", :message => "something")
    # ActionCable.server.broadcast("user:#{user.id}", :redirect => Rails.application.routes.url_helpers.battle_path(self))
    battle_path = Rails.application.routes.url_helpers.battle_path(battle)
    battle.characters.each do |character|
      # ActionCable.server.broadcast("user:#{character.user.id}", :redirect => battle_path)
      UserChannel.broadcast_to(character.user, :redirect => battle_path)
    end
  end
end

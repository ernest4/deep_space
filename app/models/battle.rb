# TODO: specs
class Battle < ApplicationRecord
  include Participatable
  STATES = ["waiting", "live", "finished"].freeze
  include Stateful

  scope :duel, -> { where(:player_limit => 2) }
  scope :team, -> { where("player_limit > ?", 2) }

  def add_participant!(participant)
    with_lock do
      raise BattleIsFull if full?

      Participation.create!(:character => participant, :participatable => self)
    end
  end

  def start!
    ActiveRecord::Base.transaction do
      update!(:state => "live")
      characters.each { |character| character.update!(:state => "battling") }
    end
    # ActionCable.server.broadcast("battle_#{battle.id}_user_#{user.id}", :message => "something")
    # ActionCable.server.broadcast("user:#{user.id}", :redirect => Rails.application.routes.url_helpers.battle_path(self))
    characters.each do |character|
      battle_path = Rails.application.routes.url_helpers.battle_path(self)
      # ActionCable.server.broadcast("user:#{character.user.id}", :redirect => battle_path)
      UserChannel.broadcast_to(character.user, :redirect => battle_path)
    end
  end

  def full?
    player_limit == participations.count
  end

  def duel?
    player_limit == 2
  end

  def team?
    !duel?
  end
end

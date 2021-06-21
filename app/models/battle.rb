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

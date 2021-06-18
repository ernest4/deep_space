# TODO: specs
module Participatable
  extend ActiveSupport::Concern

  included do
    has_many :participations, :as => :participatable
    has_many :characters, :through => :participations
  end
end

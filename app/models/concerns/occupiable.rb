# TODO: specs
module Occupiable
  extend ActiveSupport::Concern

  included do
    def self.occupier
      has_many :occupations
    end

    def self.occupies(occupiables)
      has_many occupiables,
               :through => :occupations,
               :source => :occupiable,
               :source_type => occupiables.to_s.singularize.capitalize
    end

    def self.occupied
      has_many :occupations, :as => :occupiable
    end

    def self.occupiers(occupiers)
      has_many occupiers, :through => :occupations
    end
  end
end

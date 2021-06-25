# TODO: specs
module Composite
  extend ActiveSupport::Concern

  included do
    # def self.composer
    #   has_many :components, :as => :composer
    # end

    def self.composes(composables)
      has_many :components, :as => :composer # slightly less efficient but only costs at start up and makes DLS much nicer on the including model
      has_many composables,
               :through => :components,
               :source => :composable,
               :source_type => composables.to_s.singularize.capitalize
    end

    def add_component(composable)
      # TODO: ...
    end

    def remove_component(composable)
      # TODO: ...
    end

    # def self.composable
    #   has_many :components, :as => :composable
    # end

    def self.composer(composer)
      has_many :components, :as => :composable # slightly less efficient but only costs at start up and makes DLS much nicer on the including model
      has_many composer, :through => :components, :source => :composer, :source_type => composer.to_s.singularize.capitalize
    end
  end
end

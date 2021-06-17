# TODO: specs
module Occupiable
  extend ActiveSupport::Concern

  included do
    has_many :occupations, :as => :occupiable
    has_many :characters, :through => :occupations
  end
end

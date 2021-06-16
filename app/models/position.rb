# TODO: specs
class Position < ApplicationRecord
  belongs_to :positionable, :polymorphic => true

  # TODO: specs
  scope :around, lambda { |center:, range:|
                   min_x = center[:x] - range
                   max_x = center[:x] + range
                   min_y = center[:y] - range
                   max_y = center[:y] + range
                   where("x > ? and x < ? and y > ? and y < ?", min_x, max_x, min_y, max_y)
                 }

  # TODO: specs
  def to_coords
    { :x => x, :y => y }
  end
end

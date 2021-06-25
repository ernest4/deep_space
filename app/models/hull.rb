# TODO: specs
class Hull < ApplicationRecord
  include Stateful
  include Composite

  states [:repairing, :ready]

  composable
  composers :ships
end

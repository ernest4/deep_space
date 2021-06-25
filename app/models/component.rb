class Component < ApplicationRecord
  belongs_to :composer, :polymorphic => true
  belongs_to :composable, :polymorphic => true
end

class Character < ApplicationRecord
  belongs_to :user

  # TODO: SPECS
  validates :name, :length => { :in => 2..12 }
end

# TODO: specs
class User < ApplicationRecord
  has_one :character
  # has_one :tutorial # ?? yeah ? or store it on user ? maybe can be a concern, different models can have different tutorials ?

  validates :google_id, :presence => true
  validates :email, :presence => true

  # TODO: specs
  scope :online, -> { where(:online => true) }

  # TODO: specs
  scope :last_online, lambda { |since|
    where("last_online > ?", since)
  }
end

# Some sample code from elsewhere
# scope :between, ->(sender_id,recipient_id) do
#   where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
# end

# scope :unread_by, lambda { |user:|
#   Conversation.where(:unseen_by => user).distinct.order('updated_at DESC')
# }

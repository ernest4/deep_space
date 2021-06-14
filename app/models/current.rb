# frozen_string_literal: true

# Place to drop global values to current request response context.
# This will be accessible app wide!
class Current < ActiveSupport::CurrentAttributes
  attribute :user, :character
  attribute :request_id, :user_agent, :ip_address

  # resets { Time.zone = nil }

  def user=(user)
    super
    self.character = user.character
    # Time.zone = user.time_zone
  end
end

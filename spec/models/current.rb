# frozen_string_literal: true

# Place to drop global values to current request response context.
# This will be accessible app wide!
class Current < ActiveSupport::CurrentAttributes
  attribute :user
  # attribute :language
  # attribute :currency
end

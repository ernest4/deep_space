# frozen_string_literal: true

class ApplicationAction
  def self.call(*args, &block)
    new(*args, &block).call
  end
end

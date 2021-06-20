# TODO: specs
module Stateful
  extend ActiveSupport::Concern

  included do
    self::STATES.each do |state|
      scope state, -> { where(:state => state) }
    end

    def method_missing(method, *arguments, &block)
      method = method.to_s.chomp("?")
      if self.class::STATES.include?(method)
        state == method
      else
        super
      end
    end
  end


  # included do |base|
  #   base.const_get(STATES).each do |state|
  #     scope state, -> { where(:state => state) }
  #   end

  #   def method_missing(method, *arguments, &block)
  #     method = method.to_s.chomp("?")
  #     if base.const_get(STATES).include?(method)
  #       state == method
  #     else
  #       super
  #     end
  #   end
  # end
end

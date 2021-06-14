class ApplicationRecord < ActiveRecord::Base
  include Exceptions
  
  self.abstract_class = true
end

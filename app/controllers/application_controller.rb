class ApplicationController < ActionController::Base
  include Exceptions
  include ErrorLogging
  include Authentication
  include SetCurrentRequestDetails
  include Flashy
  include BattleFocused
end

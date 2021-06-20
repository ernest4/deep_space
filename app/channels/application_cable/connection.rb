module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # rescue_from StandardError, :with => :report_error
    identified_by :current

    def connect
      self.current = find_verified_user_from_cookies
    end

    private

    # TODO: might need to stop using the reject_unauthorized_connection check here as this stops
    # socket traffic for non logged in users (when it might be desirable?)
    def find_verified_user_from_cookies
      user = User.find(cookies.encrypted[:user_id])
      OpenStruct.new(:user => user, :character => user.character)
    rescue ActiveRecord::RecordNotFound
      reject_unauthorized_connection
    end

    # def report_error(e)
    #   # TODO: rollbar
    # end
  end
end

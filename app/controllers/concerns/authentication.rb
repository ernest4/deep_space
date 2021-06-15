module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate
  end

  private

  def authenticate
    # return if allow_unauthenticated?

    Current.user = User.find(cookies.encrypted[:user_id])
  rescue ActiveRecord::RecordNotFound => e
    error_message = "Authentication error"
    log_error(error_message, e)
    flash_hash = add_flash_error({}, error_message)
    redirect_to root_path, :flash => flash_hash
  end

  def allow_unauthenticated
    @allow_unauthenticated = true
  end

  def allow_unauthenticated?
    @allow_unauthenticated
  end

  def logged_in?
    cookies.encrypted[:user_id].present?
  end
end

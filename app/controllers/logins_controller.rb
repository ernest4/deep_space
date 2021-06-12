# app/controllers/logins_controller.rb
class LoginsController < ApplicationController
  def new; end

  def create
    if (user = authenticate_with_google)
      cookies.signed[:user_id] = user.id
      redirect_to user
    else
      redirect_to new_session_url, :alert => 'authentication_failed'
    end
  end

  private

  def authenticate_with_google
    if (id_token = flash[:google_sign_in][:id_token])
      google_identity = GoogleSignIn::Identity.new(id_token)
      # name
      # email_address
      # user_id: A string that uniquely identifies a single Google user. Use this, not email_address, to associate a Google user with an application user. A Google user’s email address may change, but their user_id will remain constant.
      # email_verified?
      # avatar_url
      # locale
      # hosted_domain: The user’s hosted G Suite domain, provided only if they belong to a G Suite.
      # given_name: The user's given name.
      # family_name: The user's last name.
      email_address
      User.find_by(:google_id => google_identity.user_id)
    elsif (error = flash[:google_sign_in][:error])
      logger.error "Google authentication error: #{error}"
      nil
    end
  end
end
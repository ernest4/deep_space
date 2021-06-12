# TODO: specs !!!

class LoginsController < ApplicationController
  # TODO: do we need this???
  def new; end

  def create
    # TODO: handle the separate cases when auth fails because of error
    # vs new user creation (send to welcome page)
    user = authenticate_with_google

    # TODO: trying to be functional haha
    # trying to push out all actions to very end
    if user
      cookies.signed[:user_id] = user.id
      return redirect_to new_user?(user) ? welcome_path : galaxy_path
    end

    flash_hash = add_flash_error({}, "Authentication Failed")
    redirect_to root_path, :flash => flash_hash
  end

  private

  def authenticate_with_google
    if (id_token = flash[:google_sign_in][:id_token])
      google_identity = GoogleSignIn::Identity.new(id_token)
      initialize_user(google_identity)
    elsif (error = flash[:google_sign_in][:error])
      logger.error "Google authentication error: #{error}"
      nil
    end
  end

  def initialize_user(google_identity)
    # name
    # email_address
    # user_id: A string that uniquely identifies a single Google user. Use this, not email_address, to associate a Google user with an application user. A Google user’s email address may change, but their user_id will remain constant.
    # email_verified?
    # avatar_url
    # locale
    # hosted_domain: The user’s hosted G Suite domain, provided only if they belong to a G Suite.
    # given_name: The user's given name.
    # family_name: The user's last name.
    # email_address
    user = User.find_by(:google_id => google_identity.user_id)
    user = create_user(google_identity) if user.blank?
    user = update_user(user)
    user.save!
  end

  def create_user(google_identity)
    User.new(
      :google_id => google_identity.user_id,
      :email => google_identity.email_address
    )
  end

  def update_user(user)
    user.last_online = Time.current
    user.online = true
  end

  def new_user?(user)
    user.character.exists?
  end
end

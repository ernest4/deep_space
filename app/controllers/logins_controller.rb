# TODO: specs !!!

class LoginsController < ApplicationController
  # TODO: do we need this???
  def new; end

  def create
    id_token = flash[:google_sign_in][:id_token]
    return authenticate_with_google(id_token) if id_token.present?

    report_errors(flash[:google_sign_in][:error])
    redirect_to root_path, :flash => flash_hash
  end

  private

  def google_auth_success?
    flash[:google_sign_in][:id_token].present?
  end

  def authenticate_with_google(id_token)
    google_identity = GoogleSignIn::Identity.new(id_token)
    user = User.find_by(:google_id => google_identity.user_id) # action...
    user = create_user(google_identity) if user.blank? # calc...
    user = update_user_login(user) # calc...
    user.save # action...

    # TODO: trying to be functional haha
    # trying to push out all actions to very end
    if user.errors.blank?
      cookies.signed[:user_id] = user.id
      redirect_to new_user?(user) ? welcome_path : galaxy_path
    end

    report_errors(user.errors)
    redirect_to root_path, :flash => flash_hash
  end

  # def initialize_user(google_identity)
  #   # name
  #   # email_address
  #   # user_id: A string that uniquely identifies a single Google user. Use this, not email_address, to associate a Google user with an application user. A Google user’s email address may change, but their user_id will remain constant.
  #   # email_verified?
  #   # avatar_url
  #   # locale
  #   # hosted_domain: The user’s hosted G Suite domain, provided only if they belong to a G Suite.
  #   # given_name: The user's given name.
  #   # family_name: The user's last name.
  #   # email_address
  #   user = User.find_by(:google_id => google_identity.user_id)
  #   user = create_user(google_identity) if user.blank?
  #   user = update_user_login(user)
  #   # user.save!
  # end

  def create_user(google_identity)
    User.new(
      :google_id => google_identity.user_id,
      :email => google_identity.email_address
    )
  end

  def update_user_login(user)
    user.last_online = Time.current
    user.online = true
  end

  def new_user?(user)
    user.character.present?
  end

  def report_errors(errors)
    # TODO: Rollbar error as well!
    logger.error error_message(errors)
    flash_hash = add_flash_error({}, error_message(errors))
  end

  def error_message(errors)
    "Google authentication error: #{errors.join(" ")}"
  end
end

# TODO: specs !!!

class LoginsController < ApplicationController
  before_action :authenticate, :except => [:create]

  def create
    user = user_find_or_create_by_google_id
    user.track_online_status!
    cookies.encrypted[:user_id] = user.id
    redirect_to appropriate_path_for_user(user)
  rescue StandardError, GoogleSignInError => e
    error_message = "Authentication error"
    log_error(error_message, e, :user => user)
    flash_hash = add_flash_error({}, with_support(error_message))
    redirect_to root_path, :flash => flash_hash
  end

  def destroy
    user.track_offline_status!
    reset_session
    cookies.clear

    flash_hash = add_flash_success({}, "Logged out.")
    redirect_to root_path, :flash => flash_hash
  rescue StandardError => e
    error_message = "Logout error"
    log_error(error_message, e, :user => user)
    flash_hash = add_flash_error({}, with_support(error_message))
    redirect_to root_path, :flash => flash_hash
  end

  private

  def user_find_or_create_by_google_id
    id_token = flash[:google_sign_in]["id_token"]
    raise GoogleSignInError, flash[:google_sign_in]["error"] if id_token.blank?

    google_identity = GoogleSignIn::Identity.new(id_token)
    google_id = google_identity.user_id
    email_address = google_identity.email_address

    user = User.find_by(:google_id => google_id)
    user.presence || User.create!(:google_id => google_id, :email => email_address)
  end

  def appropriate_path_for_user(user)
    new_user?(user) ? welcome_path : galaxy_path
  end

  # # def initialize_user(google_identity)
  # #   # name
  # #   # email_address
  # #   # user_id: A string that uniquely identifies a single Google user. Use this, not email_address, to associate a Google user with an application user. A Google user’s email address may change, but their user_id will remain constant.
  # #   # email_verified?
  # #   # avatar_url
  # #   # locale
  # #   # hosted_domain: The user’s hosted G Suite domain, provided only if they belong to a G Suite.
  # #   # given_name: The user's given name.
  # #   # family_name: The user's last name.
  # #   # email_address
  # #   user = User.find_by(:google_id => google_identity.user_id)
  # #   user = create_user(google_identity) if user.blank?
  # #   user = update_user_login(user)
  # #   # user.save!
  # # end

  def new_user?(user)
    user.character.blank?
  end
end

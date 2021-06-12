# TODO: specs !!!

class LoginsController < ApplicationController
  # TODO: do we need this???
  def new; end

  def create
    if (user = authenticate_with_google)
      cookies.signed[:user_id] = user.id
      redirect_to user
    else
      # redirect_to root_path, :flash => { :g => { :error => 'Authentication Failed', :success => 'testing success', :info => 'testing info' } }

      flash_hash = add_flash_error({}, "Auth failed")
      flash_hash = add_flash_error(flash_hash, "Auth failed 2")
      flash_hash = add_flash_success(flash_hash, "works 1")
      flash_hash = add_flash_info(flash_hash, "info 1")
      flash_hash = add_flash_info(flash_hash, "info 2")
      flash_hash = add_flash_info(flash_hash, "info 3")

      redirect_to root_path, :flash => flash_hash
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
      # email_address
      User.find_by(:google_id => google_identity.user_id)
    elsif (error = flash[:google_sign_in][:error])
      logger.error "Google authentication error: #{error}"
      nil
    end
  end
end

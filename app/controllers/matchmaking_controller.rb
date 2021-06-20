class MatchmakingController < ApplicationController
  # # GET /users or /users.json
  # def index
  #   @users = User.all
  # end

  # # GET /users/1 or /users/1.json
  # def show
  # end

  # # GET /users/new
  # def new
  #   @user = User.new
  # end

  # # GET /users/1/edit
  # def edit
  # end

  # POST /users or /users.json
  def create
    # debugger
    # @user = User.new(user_params)

    # Character.create!(:name => character_params[:name], :user => Current.user)
    Current.character.update!(:state => "seeking_battle")
    # MatchmakingWorker.perform_in(5.seconds, Current.character.id) # add a bit delay to let the user browser load in the ActionCable listener
    MatchmakingWorker.perform_async(Current.character.id)

    # respond_to do |format|
    #   if @user.save
    #     format.html { redirect_to @user, :notice => "User was successfully created." }
    #     format.json { render :show, :status => :created, :location => @user }
    #   else
    #     format.html { render :new, :status => :unprocessable_entity }
    #     format.json { render :json => @user.errors, :status => :unprocessable_entity }
    #   end
    # end
    redirect_back :fallback_location => galaxy_path
  rescue ActiveRecord::RecordInvalid => e
    error_message = "Record Invalid"
    log_error(error_message, e, :user => Current.user)

    flash_hash = {}
    e.record.errors.each do |error|
      # debugger
      # attribute_error = { :attribute => error.attribute, :type => error.type, :options => error.options}
      # flash_hash = add_flash_error(flash_hash, attribute_error)
      flash_hash = add_flash_error(flash_hash, error)
    end
    # redirect_to root_path, :flash => flash_hash
    redirect_back :fallback_location => galaxy_path, :flash => flash_hash
  end

  # # PATCH/PUT /users/1 or /users/1.json
  # def update
  #   respond_to do |format|
  #     if @user.update(user_params)
  #       format.html { redirect_to @user, notice: "User was successfully updated." }
  #       format.json { render :show, status: :ok, location: @user }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def cancel
    Current.character.update!(:state => nil) # TODO: handle case when character already in "battling" state ...
    redirect_back :fallback_location => galaxy_path
  rescue ActiveRecord::RecordInvalid => e
    error_message = "Record Invalid"
    log_error(error_message, e, :user => Current.user)

    flash_hash = {}
    e.record.errors.each do |error|
      # debugger
      # attribute_error = { :attribute => error.attribute, :type => error.type, :options => error.options}
      # flash_hash = add_flash_error(flash_hash, attribute_error)
      flash_hash = add_flash_error(flash_hash, error)
    end
    # redirect_to root_path, :flash => flash_hash
    redirect_back :fallback_location => galaxy_path, :flash => flash_hash
  end

  # # DELETE /users/1 or /users/1.json
  # def destroy
  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to users_url, notice: "User was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private

  # # Use callbacks to share common setup or constraints between actions.
  # def set_user
  #   @user = User.find(params[:id])
  # end

  # # Only allow a list of trusted parameters through.
  def character_params
    # params.fetch(:user, {})
    params.require(:character).permit(:name)
  end
end

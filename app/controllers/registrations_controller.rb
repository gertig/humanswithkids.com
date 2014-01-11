class RegistrationsController < Devise::RegistrationsController
  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, account_update_params)
      @user.update_with_password(account_update_params)
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      account_update_params.delete(:current_password)
      @user.update_without_password(account_update_params)
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  private

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    # user.email != params[:user][:email] ||
      params[:password].present?
  end
end

# # app/controllers/registrations_controller.rb
# class RegistrationsController < Devise::RegistrationsController
#   # def new
#   #   super
#   # end

#   # def create
#   #   # add custom create logic here
#   # end

#   def update
#     # For Rails 4
#     account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
#     # For Rails 3
#     # account_update_params = params[:user]

#     # required for settings form to submit when password is left blank
#     if account_update_params[:password].blank?
#       account_update_params.delete("password")
#       account_update_params.delete("password_confirmation")
#       account_update_params.delete("current_password")
#     end

#     @user = User.find(current_user.id)
#     if @user.update_attributes(account_update_params)
#       set_flash_message :notice, :updated
#       # Sign in the user bypassing validation in case his password changed
#       sign_in @user, :bypass => true
#       redirect_to after_update_path_for(@user)
#     else
#       render "edit"
#     end
#   end

# end 
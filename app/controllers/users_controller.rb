class UsersController < ApplicationController
  class UsersController < ApplicationController
    def update
      if @user.update(user_params)
        redirect_to @user, notice: 'Profile updated successfully'
      else
        render :edit
      end
    end

    private

    def user_params
      params.require(:user).permit(:avatar, :username, :email)
    end
  end
end

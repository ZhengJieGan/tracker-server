class UsersController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? }
    wrap_parameters :user, include: [:name, :email, :password, :password_confirmation]

    def new
      @user = User.new
      render json: @user
    end

    def create
        @user = User.new(user_params)
        if User.where(email: @user.email).exists?
            render json: { message: "A user with this email already exists" }
        elsif @user.save
            render json: @user
        else
            render json: { message: @user.errors}
        end
      end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
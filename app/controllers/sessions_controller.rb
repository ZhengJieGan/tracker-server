class SessionsController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? }

    def new
        render json: {message: "login test"}
    end

    def user
        render json: {user: $user_id}
    end
  
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        @posts = Post.where(user_id: user._id)
        if user && user.authenticate(params[:session][:password])
            $user_id = user
            puts session[:user_id]
            render json: { user: user, data: @posts }
        else
            render json: { message: "failed" }
        # render 'new'
        end
    end
  
    def destroy
        # log_out
        render json: { message: "logged out" }
    end
end
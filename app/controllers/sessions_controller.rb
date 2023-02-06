class SessionsController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? }

    def new
        render json: {message: "login test"}
    end
  
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            render json: { message: user }
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
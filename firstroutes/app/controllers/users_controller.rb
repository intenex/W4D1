class UsersController < ApplicationController
    def index
        @users = User.all
    
        render json: @users 
    end

    def create
        user = User.new(user_params)
        if user.save
          render json: user
        else
          render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        user = User.find_by(id: params[:id])
        render json: user
    end

    def update
        user = User.find_by(id: params[:id])
        # if params[:user] # if this is nil we're doing nil[:name]
        #     user.name = params[:user][:name] if params[:user][:name]
        #     user.email = params[:user][:email] if params[:user][:email]
        # end
        if params[:user]
            if user.update(user_params)
                render json: user
            else
                render json: user.errors.full_messages, status: :unprocessable_entity
            end
        end
        # if user.save
        #     render json: user
        # else
        #     render json: user.errors.full_messages, status: :unprocessable_entity
        # end
    end

    def destroy
        user = User.find_by(id: params[:id])

        if user.delete
            redirect_to users_url
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email)
    end
end

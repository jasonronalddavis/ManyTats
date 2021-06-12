class UsersController < ApplicationController

    protect_from_forgery with: :exception
    before_action :authenticate_user, only: [:show]

    def new
     #binding.pry
     @user = User.new
    end

    def create
     #   binding.pry

        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def show
        @tats = User.find(session[:user_id]).tats
        @user = User.find_by(id: params[:id])
        # binding.pry
        # if current_user.admin == false
        #     if current_user != @user
        #         redirect_to root_path
        #     end
        # end
    end

    # def destroy
    #     @user = User.find(params[:id])
    #     @user.destroy
    #     redirect_to root_path
    # end

    private

    def user_params
        
        params.require(:user).permit( :name, :password)
    end



end 

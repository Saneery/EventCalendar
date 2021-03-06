class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @events = @user.events
    
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
    	log_in @user
    	redirect_to @user
    else
    	render 'new'
    end
  end

  def edit
  end

  def update
    
    if @user.update(user_params)
    	redirect_to @user
    else
    	render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def correct_user
    	@user = current_user
    	redirect_to login_path if @user.nil?
    end

end

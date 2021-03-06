class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if user_params[:password] != user_params[:confirm_password]
      flash[:alert] = "password do not match"
      return render :new
    end
    if @user.save
      flash[:notice]="user saved!"
      redirect_to users_path and return
    else
      flash[:alert]="invalid email"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def destroy
    if @user = User.delete(params[:id])
      redirect_to user_path and return
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :confirm_password)
  end

end

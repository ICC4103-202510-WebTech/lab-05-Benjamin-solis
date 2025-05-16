class UsersController < ApplicationController
  def index
    @users = User.includes(:messages).all
    puts "DEBUG: Número de usuarios encontrados: #{@users.count}"
    @users = [] if @users.nil?
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "Usuario actualizado correctamente."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end

class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.all
    Rails.logger.debug "Número de usuarios encontrados: #{@users.count}"
  end

  def show
    @user = User.find(params[:id])
    @chats = Chat.where("sender_id = ? OR receiver_id = ?", @user.id, @user.id)
    @messages = @user.messages
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'Usuario creado exitosamente.'
    else
      flash.now[:alert] = "Error al crear el usuario: #{@user.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path, alert: "No tienes permiso para editar este usuario."
      return
    end
  end

  def update
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path, alert: "No tienes permiso para editar este usuario."
      return
    end

    if @user.update(user_params)
      redirect_to @user, notice: 'Usuario actualizado exitosamente.'
    else
      flash.now[:alert] = "Error al actualizar el usuario: #{@user.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end

class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @chats = Chat.for_user(current_user)
    Rails.logger.debug "Número de chats encontrados: #{@chats.count}"
  end

  def show
    unless @chat.sender_id == current_user.id || @chat.receiver_id == current_user.id
      redirect_to root_path, alert: "No tienes permiso para acceder a este chat. Solo puedes ver los chats donde eres remitente o destinatario."
      return
    end
    @messages = @chat.messages
  end

  def new
    @chat = Chat.new
    @chat.sender = current_user
  end

  def create
    # Verificar si ya existe un chat entre estos usuarios
    existing_chat = Chat.where(
      "(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)",
      current_user.id, chat_params[:receiver_id],
      chat_params[:receiver_id], current_user.id
    ).first

    if existing_chat
      redirect_to existing_chat, notice: "Ya tienes un chat con esta persona."
      return
    end

    @chat = Chat.new(chat_params)
    @chat.sender = current_user

    if @chat.save
      redirect_to @chat, notice: 'Chat creado exitosamente.'
    else
      flash.now[:alert] = "Error al crear el chat: #{@chat.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def edit
    unless @chat.sender_id == current_user.id
      redirect_to root_path, alert: "No tienes permiso para editar este chat. Solo puedes editar los chats donde eres remitente."
      return
    end
  end

  def update
    unless @chat.sender_id == current_user.id
      redirect_to root_path, alert: "No tienes permiso para editar este chat. Solo puedes editar los chats donde eres remitente."
      return
    end

    if @chat.update(chat_params)
      redirect_to @chat, notice: 'Chat actualizado exitosamente.'
    else
      flash.now[:alert] = "Error al actualizar el chat: #{@chat.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  def destroy
    unless @chat.sender_id == current_user.id
      redirect_to root_path, alert: "No tienes permiso para eliminar este chat. Solo puedes eliminar los chats donde eres remitente."
      return
    end

    @chat.destroy
    redirect_to chats_path, notice: 'Chat eliminado exitosamente.'
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:receiver_id)
  end
end

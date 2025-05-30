class MessagesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @messages = Message.where(user_id: current_user.id)
    Rails.logger.debug "Número de mensajes encontrados: #{@messages.count}"
  end

  def show
    @message = Message.find(params[:id])
    unless @message.user_id == current_user.id
      redirect_to root_path, alert: "No tienes permiso para ver este mensaje. Solo puedes ver tus propios mensajes."
      return
    end
  end

  def new
    @message = Message.new
    @message.user = current_user
    @message.chat_id = params[:chat_id] if params[:chat_id]
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user

    if @message.save
      redirect_to @message.chat, notice: 'Mensaje enviado exitosamente.'
    else
      flash.now[:alert] = "Error al enviar el mensaje: #{@message.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def edit
    @message = Message.find(params[:id])
    unless @message.user_id == current_user.id
      redirect_to root_path, alert: "No tienes permiso para editar este mensaje. Solo puedes editar tus propios mensajes."
      return
    end
  end

  def update
    @message = Message.find(params[:id])
    unless @message.user_id == current_user.id
      redirect_to root_path, alert: "No tienes permiso para editar este mensaje. Solo puedes editar tus propios mensajes."
      return
    end

    if @message.update(message_params)
      redirect_to @message.chat, notice: 'Mensaje actualizado exitosamente.'
    else
      flash.now[:alert] = "Error al actualizar el mensaje: #{@message.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def message_params
    params.require(:message).permit(:body, :chat_id)
  end
end

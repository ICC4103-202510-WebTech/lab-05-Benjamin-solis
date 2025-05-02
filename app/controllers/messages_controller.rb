class MessagesController < ApplicationController
  def index
    @messages = Message.all
    puts "DEBUG: Número de mensajes encontrados: #{@messages.count}"
    @messages = [] if @messages.nil?
  end

  def show
    @message = Message.find(params[:id])
  end
  
  def new
    @message = Message.new
    @chats = Chat.all
    @users = User.all
  end

  def create
    @message = Message.new(message_params)
    
    if @message.save
      redirect_to @message.chat, notice: 'Mensaje creado exitosamente.'
    else
      @chats = Chat.all
      @users = User.all
      render :new
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:body, :chat_id, :user_id)
  end
end
class ChatsController < ApplicationController
  def index
    @chats = Chat.all
    puts "DEBUG: Número de chats encontrados: #{@chats.count}"
    @chats = [] if @chats.nil?
  end

  def show
    @chat = Chat.find(params[:id])
    @messages = Message.where(chat_id: @chat.id)
  end
end
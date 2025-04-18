class MessagesController < ApplicationController
  def index
    @messages = Message.all
    puts "DEBUG: Número de mensajes encontrados: #{@messages.count}"
    @messages = [] if @messages.nil?
  end

  def show
    @message = Message.find(params[:id])
  end
end
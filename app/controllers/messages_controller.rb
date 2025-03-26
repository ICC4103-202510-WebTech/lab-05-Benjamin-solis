class MessagesController < ApplicationController
    def create
      @message = Message.new(message_params)
      if @message.save
        redirect_to root_path, notice: 'Gracias por tu mensaje, nos pondremos en contacto contigo pronto.'
      else
        render 'home/contact'
      end
    end
  
    private
  
    def message_params
      params.require(:message).permit(:name, :email, :content)
    end
  end
  
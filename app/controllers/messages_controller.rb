class MessagesController < ApplicationController

	def contact
		@message = Message.new
	end

	def create
	  @message = Message.new(message_params)

	  if @message.valid?
	  	MessageMailer.contact(@message).deliver_now
	    redirect_to new_message_url, notice: "Thanks for your email!"
	  else
	    render :contact
	  end
	end

	private

	def message_params
	  params.require(:message).permit(:name, :email, :body)
	end
end

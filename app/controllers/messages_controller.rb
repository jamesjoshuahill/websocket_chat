class MessagesController < ApplicationController
  before_action :set_message, only: [:destroy]
  before_filter :authenticate_user!, only: [:create, :destroy]

  # GET /messages
  def index
    @messages = Message.all
    @message = Message.new
  end

  # POST /messages
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html do
          WebsocketRails[:chat].trigger 'new', @message
          redirect_to root_path, notice: 'Message was posted.'
        end
      else
        render action: 'new'
      end
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:name, :content)
    end
end

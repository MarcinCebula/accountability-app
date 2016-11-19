class RegistrationController < ApplicationController
  def phone_number
    @user = User.new
  end
  def process_phone_number
    generated_password = 'password'
    @user = User.new(user_params.merge(password: generated_password))
    respond_to do |format|
      if @user.save
        format.html {
          @twillio = Twilio::REST::Client.new
          @twillio.messages.create(
                                   from: '+13472692547',
                                   to: "+1#{@user.phone}",
                                   body: "Thanks for joining #{APP_NAME}. You password is: #{generated_password}"                                   )

          redirect_to "#{request.referer}", flash: {  success: "Thanks" }
        }
      else
        format.html {
          flash.now['error'] =  "#{@blog.errors.full_messages.to_sentence}"
          render :phone_number
        }
      end
    end
  end

  def user_params
    params.require(:user).permit(
                                 :phone
                                 )
  end
end

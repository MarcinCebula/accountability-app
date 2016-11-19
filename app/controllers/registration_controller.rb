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
                                   body: "Hi #{@user.name}. Thanks for joining #{APP_NAME}. You password is: '#{generated_password}'"
                                   )
          sign_in(:user, @user)
          redirect_to goals_registration_index_path


        }
      else
        format.html {
          @twillio = Twilio::REST::Client.new
          @twillio.messages.create(
                                   from: '+13472692547',
                                   to: "+1#{@user.phone}",
                                   body: "You already have an account on #{APP_NAME}. Please login #{new_user_session_url}"
                                   )



          flash.now['error'] =  "#{@user.errors.full_messages.to_sentence}"
          render :phone_number
        }
      end
    end
  end

  def goals
    @user = current_user
  end

  def update
    binding.pry
    putes 'test'
  end


  def user_params
    params.require(:user).permit(
                                 :name,
                                 :phone,
                                 :starting_weight,
                                 :target_weight
                                 )
  end
end

class RegistrationController < ApplicationController
  def intro
   end
  def onboard1
    end
  def onboard2
    end
  def onboard3
    end
  def phone_number
    @user = User.new
  end
  def process_phone_number
    generated_password = 'password'
    @user = User.new(user_params.merge(password: generated_password))
    respond_to do |format|
      if @user.save

        format.html {
          if REAL
          @twillio = Twilio::REST::Client.new
          @twillio.messages.create(
                                   from: '+13472692547',
                                   to: "+1#{@user.phone}",
                                   body: "Hi #{@user.name}. Thanks for joining #{APP_NAME}. Lets get Fit!"
                                   )
          end
          sign_in(:user, @user)
          redirect_to schedule_registration_index_path


        }
      else
        format.html {
          if REAL
            @twillio = Twilio::REST::Client.new
            @twillio.messages.create(
                                     from: '+13472692547',
                                     to: "+1#{@user.phone}",
                                     body: "You already have an account on #{APP_NAME}. Please login #{new_user_session_url}"
                                     )
          end



          flash.now['error'] =  "#{@user.errors.full_messages.to_sentence}"
          render :phone_number
        }
      end
    end
  end

  def goals
    @user = current_user
  end

  def schedule
    @user = current_user
  end

  def friends
    @user = current_user
  end

  def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html {
          flash.now['error'] =  "Thanks for setting Goals!"
          redirect_to params[:user][:next_path]
        }
      else
        format.html {
          flash.now['error'] =  "#{@user.errors.full_messages.to_sentence}"
          render :goals
        }
      end
    end
  end


  def user_params
    if params[:user][:schedule].present?
      params[:user][:schedule] = params[:user][:schedule].map(&:presence).compact
    end
    params.require(:user).permit(
                                 :name,
                                 :phone,
                                 :starting_weight,
                                 :target_weight,
                                 :default_exercise_time,
                                 :schedule => [],
                                 :friends_attributes => [:name, :phone]
                                 )
  end
end

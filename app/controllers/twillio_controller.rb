class TwillioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def sms
    @twillio = Twilio::REST::Client.new
    if params['Body'].downcase.include?('yes')
      @twillio.messages.create(
                               from: '+13472692547',
                               to: params['From'],
                               body: 'Good Job'
                               )
    end
    if params['Body'].downcase == 'nop'
      @twillio.messages.create(
                               from: '+13472692547',
                               to: params['From'],
                               body: 'Please Remember to go on Friday at 6pm'
                               )
    end
    if params['Body'].downcase == 'no'
      @twillio.messages.create(
                               from: '+13472692547',
                               to: params['From'],
                               body: 'You missed your activity 2 times in a row. You friend will be notified'
                               )

      User.where(phone: params['From'][-2..-1]).first.friends.each do |friend|
        @twillio.messages.create(
                                 from: '+13472692547',
                                 to: "+1#{friend.phone}",
                                 body: "You friend didn't go to the gym 2 times. inform him"
                                 )
      end
    end
  end
end

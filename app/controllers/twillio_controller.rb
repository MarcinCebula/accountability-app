class TwillioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def sms
    binding.pry
    puts 'tst'
  end
end

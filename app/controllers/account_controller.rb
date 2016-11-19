class AccountController < ApplicationController
  before_action :authenticate_user!

  def hi
  end
end

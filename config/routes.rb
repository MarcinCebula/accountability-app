Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html

  resources :registration, only: [:index] do
    get 'phone-number', as: :phonenumber, on: :collection
  end

  post 'twillio/sms' => 'twillio#sms'
  root to: "registration#phone_number"
end

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html

  resources :registration, only: [:index, :update] do
    get 'intro', as: :intro, on: :collection
    get 'onboard1', as: :onboard1, on: :collection
    get 'onboard2', as: :onboard2, on: :collection
    get 'onboard3', as: :onboard3, on: :collection
    get 'phone-number', as: :phonenumber, on: :collection
    post 'process_phone_number', as: :process_phone_number, on: :collection

    get 'goals', as: :goals, on: :collection
    get 'schedule', as: :shedule, on: :collection
  end

  resources :account, only: [] do
    get 'hi', as: :hi, on: :collection
  end

  post 'twillio/sms' => 'twillio#sms'
  root to: "registration#phone_number"
end

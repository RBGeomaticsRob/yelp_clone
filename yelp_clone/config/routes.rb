Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


  # get 'restaurants' => 'restaurants#index'
  resources :restaurants do
    resources :reviews
  end

  root to: "restaurants#index"

  # devise_scope :user do
  #   get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
end

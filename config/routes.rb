Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
#  devise_scope :user do
    # get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    # get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
    # get 'github', to: 'omniauth_callbacks#github', as: :user_github_omniauth_callback
 # end

  root 'main#index'
  get '/our-items', to: 'main#our_items'
  get '/our-items/filter/:filter', to: 'main#set_user_filter', as: :set_user_filter
  post '/our-items/:item_id/claim', to: 'main#claim', as: :claim_item
  delete '/our-items/:item_id/claim', to: 'main#unclaim', as: :unclaim_item

  get '/our-users', to: 'main#our_users'

  get '/our-finances', to: 'main#our_finances'

  get '/change_user/:id', to: 'application#change_user', as: :change_user

  get '/start_crowdfunding/:item_id', to: 'main#start_crowdfunding', as: :start_crowdfunding

  resources :items do
    get "image", :on => :member
  end

  # resources :users

  resource :campaigns
end

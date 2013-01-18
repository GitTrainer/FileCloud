Filecloud::Application.routes.draw do
  resources :roles

  authenticated :user do
    root :to => 'home#index'
  end
#   root :to => "home#index"
#  devise_for :users
#  resources :users

  devise_scope :user do
    root :to => "devise/registrations#new"
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
  end

  devise_for :users, :controllers => { :registrations => "registrations", :confirmations => "confirmations" }

  match 'users/bulk_invite/:quantity' => 'users#bulk_invite', :via => :get, :as => :bulk_invite
  
  match "/users/listuser" , to: 'users#listuser', via: :get
  match "/users/:id/" , to: 'users#destroy', via: :get

  resources :users, :only => [:delete,:show, :index] do
    get 'invite', :on => :member
  end
  
end
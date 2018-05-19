Rails.application.routes.draw do
  resources :user_projects
  resources :artifacts
  resources :projects
  resources :members
  get 'home/index'

  root :to => "home#index"



  # *MUST* come *BEFORE* devise's definitions (below)
  as :user do
    # match '/user/confirmation' => 'milia/confirmations#update', :via => :put, :as => :update_user_confirmation
    match 'user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
  end

  devise_for :users, :controllers => {
      # :registrations => "milia/registrations",
      :registrations => "registrations",
      # :confirmations => "milia/confirmations",
      :confirmations => "confirmations",
      :sessions => "milia/sessions",
      :passwords => "milia/passwords",
  }
  resources :tenants do

    resources :projects do

      get 'users', on: :member

      put 'add_user', on: :member

    end

  end

  match '/plan/edit' => 'tenants#edit', via: :get, as: :edit_plan

  match '/plan/update' => 'tenants#update', via: [:put, :patch], as: :update_plan

  # get 'home/index'
  # root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

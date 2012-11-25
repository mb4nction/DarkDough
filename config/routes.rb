Pfm::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users do
    get "/" => "devise/registrations#new", :as => :new_user_registration
  end

  resources :users, :only => [:show, :edit, :update]
  resources :acumen_tests

  resources :accounts do
    collection do
      get :list
    end
  end

  resources :budgets

  resources :goals do
    collection do
      get :select
    end
  end

  resources :transactions
  resources :trends, :only => :index

  match '/home' => 'pages#show', :id => 'home'
  match '/about' => 'pages#show', :id => 'about'
  match '/how_it_works' => 'pages#show', :id => 'how_it_works'
  match '/faq' => 'pages#show', :id => 'faq'
  match '/terms_of_use' => 'pages#show', :id => 'terms_of_use'
  match '/help_create_account' => 'pages#show', :id => 'help_create_account'
  match '/dashboard' => 'dashboard#show'
  match '/sundry_legal_information' => 'pages#show', :id => 'sundry_legal_information'
  match '/privacy_security_policy' => 'pages#show', :id => 'privacy_security_policy'
  match '/community_policy' => 'pages#show', :id => 'community_policy'
  match '/pricing' => 'pages#show', :id => 'pricing'
  

  resource :contact_us, :only => [:create]
  match '/contact_us' => 'contact_us#new'

  root to: 'pages#home'

end

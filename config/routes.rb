OMI::Application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  get 'auth/:provider/callback', to: 'authentications#create'
  get 'signout', to: 'authentications#destroy', as: :logout
  get '/auth/google_oauth2', as: 'login'

  get 'about', to: 'pages#about', as: :about
  get 'admin', to: 'pages#admin', as: :admin
  get 'dashboard', to: 'pages#dashboard', as: :dashboard

  root "pages#home"

  resources :blogs

  resources :projects do
    resources :comments, module: :projects
    member do
      put :toggle_favorite
    end
  end

  resources :ideas do
    resources :comments, module: :ideas
    member do
      put :toggle_vote
    end
  end

  get 'work', to: 'projects#work', as: :work
  get 'work/:id', to: 'projects#work_show', as: :work_show
  get 'products', to: 'projects#products', as: :products
  get 'products/:id', to: 'projects#products_show', as: :products_show
  get 'new', to: 'pages#new', as: :new
  get 'new_product', to: 'pages#new_product', as: :new_product
  get 'new_single_product', to: 'pages#new_single_product', as: :new_single_product
  get 'new_journal', to: 'pages#new_journal', as: :new_journal
  get 'new_single_journal', to: 'pages#new_single_journal', as: :new_single_journal
  get 'new_about', to: 'pages#new_about', as: :new_about

  resources :users, only: [:index, :show, :update]
  get 'my-account' => 'users#edit'
  get 'users_search_name' => 'users#search_name'

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      namespace :tags do
        get '/search' => '/api/v1/tags#search'
      end
    end
  end
end

Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  devise_for :users
    root to: "items#index"
    resources :items do
      resources :orders, only:[:index, :create]
    end

  namespace :admins do
    root to: 'toppages#index'
    resources :items, only: [:new, :create]
  end
end
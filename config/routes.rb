# forzen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  root to: 'pages#home'
  resources :quotes do
    resources :line_item_dates, except: %i[index show]
  end
end

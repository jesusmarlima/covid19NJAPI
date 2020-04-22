Rails.application.routes.draw do
  resources :channels
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/today', to: 'daily_datum#today'
  get '/state', to: 'daily_datum#state'
  get '/essex', to: 'daily_datum#essex'
  get '/all', to: 'daily_datum#all'
  get '/growth_nj', to: 'daily_datum#growth_nj'
  get '/growth_essex', to: 'daily_datum#growth_essex'
  get '/growth', to: 'daily_datum#growth'

end

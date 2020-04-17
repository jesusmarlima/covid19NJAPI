Rails.application.routes.draw do
  resources :channels
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/today', to: 'daily_datum#today'
  get '/state', to: 'daily_datum#state'
  get '/essex', to: 'daily_datum#essex'
  get '/all', to: 'daily_datum#all'
  get '/growthNJ', to: 'daily_datum#growthNJ'
  get '/growthEssex', to: 'daily_datum#growthEssex'

end

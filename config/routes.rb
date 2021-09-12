Rails.application.routes.draw do
  resources :events, only: [:index, :create]

  #post '/events', to: 'events#createEvent'
  get '/todays_stats','/today_stats','/stats', to: 'events#index'

  
end

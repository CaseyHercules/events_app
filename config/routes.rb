Rails.application.routes.draw do
  post '/events', to: 'events#createEvent'
  get '/todays_stats','/stats','/events', to: 'events#debug'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

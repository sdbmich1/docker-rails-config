Rails.application.routes.draw do
  # Simple API endpoints
  get '/api/ping', to: 'api#ping'
  get '/api/health', to: 'api#health'
  post '/api/auth', to: 'api#auth'
  
  # Legacy endpoints
  get 'ping', to: 'ping#index'
  get 'health', to: 'health#index'
  get 'test', to: 'test#index'
  
  # Authentication routes
  post 'auth/login', to: 'auth#login'
  get 'auth/verify', to: 'auth#verify'
  
  # Additional routes can be added here
end 
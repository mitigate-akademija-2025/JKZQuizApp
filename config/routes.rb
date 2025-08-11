Rails.application.routes.draw do
  devise_for :users, path: 'secure'
 
  get '/home', to: 'pages#home'
  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'

resources :entries do
  resources :questions
end
  
  # root "pages#home"
  root 'entries#index'
end

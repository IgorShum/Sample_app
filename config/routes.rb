Rails.application.routes.draw do
  get 'sessions/new'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'login' => 'sessions#new'
  post 'login' => 'session#create'
  delete 'logout' => 'session#destroy'
  
  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'signup' => 'users#new'
  resources :users
end

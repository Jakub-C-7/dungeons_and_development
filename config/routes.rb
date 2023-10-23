Rails.application.routes.draw do
  devise_for :users
  unauthenticated do 
    root 'main#home' 
  end

  authenticated do 
    root 'users#profile', as: :authenticated_root

    get '/setup', to: "users#setup",  as: :setup  
    post '/updateInterests', to: "users#update_interests", as: :update_interests

    get '/tavern', to: 'tavern#home'
    get '/questboard', to: 'tavern#quest_board'
    post 'search', to: 'tavern#search_quests'


  end
  
  get '/about', to: 'main#about'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"



end

Rails.application.routes.draw do
  devise_for :users
  unauthenticated do 
    root 'main#home' 
  end

  authenticated do 
    root 'users#profile', as: :authenticated_root

    get '/setup', to: "users#setup",  as: :setup  
    post '/updateProfile', to: "users#update_profile", as: :update_profile

    get '/tavern', to: 'tavern#home'

    get '/questboard', to: 'tavern#quest_board'
    post 'search', to: 'tavern#search_quests'
    post 'updaterecommended', to: "tavern#update_recommended"
    post 'updatemaptask', to: "active_quests#update_map_task"

    post 'addquest', to: 'tavern#add_quest'
    post 'pausequest', to: 'tavern#pause_quest'
    post 'resumequest', to: 'tavern#resume_quest'

    get '/active_quests', to: 'active_quests#home'
    get '/active_quests/update', to: 'active_quests#update'
    get '/active_quests/search', to: 'active_quests#search'

    post '/active_quests/refreshPathway', to: 'active_quests#refreshPathway'
    post '/active_quests/refreshSection', to: 'active_quests#refreshSection'
    post '/active_quests/updateTask', to: 'active_quests#updateTask'


  end
  
  get '/about', to: 'main#about'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"



end

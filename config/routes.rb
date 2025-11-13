Rails.application.routes.draw do
  
  resources :tracked_keywords do
    member do
      post :check_ranking
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
  
  root "tracked_keywords#index"
end
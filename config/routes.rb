Rails.application.routes.draw do
 
  resources :tracked_keywords do
    post :check_rank, on: :member
  end

  get "up" => "rails/health#show", as: :rails_health_check

end
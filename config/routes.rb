Rails.application.routes.draw do
  namespace :api do
    constraints lambda { |request| request.format == :json } do
      resource :locations, only: [:create]
    end
  end
end

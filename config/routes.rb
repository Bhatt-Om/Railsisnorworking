Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      draw(:user)
      draw(:event)
      draw(:event_enroll)
    end 
  end
end

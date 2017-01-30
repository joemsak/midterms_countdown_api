Rails.application.routes.draw do
  resources :responses, only: :show
end

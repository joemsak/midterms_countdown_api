Rails.application.routes.draw do
  resource :response, only: :show
end

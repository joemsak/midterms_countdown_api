Rails.application.routes.draw do
  resources :local_election_links, only: :index
end

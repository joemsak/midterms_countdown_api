Rails.application.routes.draw do
  resources :local_election_links, only: :index
  match '*any' => 'application#options', :via => [:options]
end

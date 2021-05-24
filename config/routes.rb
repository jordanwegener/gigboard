Rails.application.routes.draw do
  root to: "gigs#index"
  resources :gigs, :bands, :negotiations
  post "/gigs/new", controller: "gigs", action: "create"
  post "/bands/new", controller: "bands", action: "new"
  devise_for :users
end

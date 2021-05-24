Rails.application.routes.draw do
  root to: "gigs#index"
  resources :gigs, :bands, :negotiations
  post "/gigs/new", controller: "gigs", action: "new"
  post "/bands/new", controller: "bands", action: "new"
  devise_for :users
end

Rails.application.routes.draw do
  root "gigs#index"
  resources :gigs, :bands, :negotiations
  post "/gigs/new", controller: "gigs", action: "new"
  # devise_for :users
end

Rails.application.routes.draw do
  root "gigs#index"
  resources :gigs, :bands, :negotiations
  # devise_for :users
end

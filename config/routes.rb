Rails.application.routes.draw do
  devise_for :users
  # resources :gigs, only: [:create]
  root to: "gigs#index"
  # devise_for :users, skip: :all
  # devise_scope :user do
  #   get "/users/sign_in", to: "devise/sessions#new"
  #   get "/users/sign_out", to: "devise/sessions#destroy"
  #   post "/users/sign_in", to: "devise/sessions#create"
  #   delete "/users/sign_out", to: "devise/sessions#destroy"
  #   get "/users/password/new", to: "devise/passwords#new"
  #   get "/users/password/edit", to: "devise/passwords#edit"
  #   patch "/users/password", to: "devise/passwords#update"
  #   put "/users/password", to: "devise/passwords#update"
  #   post "/users/password", to: "devise/passwords#create"
  #   get "/users/cancel", to: "devise/registrations#cancel"
  #   get "/users/sign_up", to: "devise/registrations#new"
  #   get "/users/edit", to: "devise/registrations#edit"
  #   patch "/users", to: "devise/registrations#update"
  #   put "/users", to: "devise/registrations#update"
  #   delete "/users", to: "devise/registrations#destroy"
  #   post "/users", to: "devise/registrations#create"
  # end
  # gigs paths
  get "/users/index", to: "users#index", as: "user"
  get "/gigs/index", to: "gigs#index", as: "gigs"
  get "/gigs/new", to: "gigs#new", as: "new_gig"
  post "/gigs/", to: "gigs#create", as: "create_gig"
  get "/gigs/:id/edit", to: "gigs#edit", as: "edit_gig"
  patch "/gigs/", to: "gigs#update", as: "update_gig"
  get "/gigs/:id/book", to: "negotiations#new", as: "new_negotiation"
  post "gigs/:id/book", to: "negotiations#create", as: "create_negotiation"
  get "/gigs/:id", to: "gigs#show", as: "gig"
  # bands paths
  get "/bands/new", to: "bands#new", as: "new_band"
  post "/bands/new", to: "bands#create", as: "create_band"
  get "/bands/:id", to: "bands#show", as: "band"
  get "/bands/:id/edit", to: "bands#edit", as: "edit_band"
  put "/bands/:id/", to: "bands#update", as: "update_band"
  # negotiations paths
  get "negotiation/:id", to: "negotiations#show", as: "negotiation"
  get "negotiations/:gig_id", to: "negotiations#index", as: "negotiations"
  patch "/negotiation/:id/accept", to: "negotiations#accept", as: "accept_negotiation"
  patch "/negotiation/:id/reject", to: "negotiations#reject", as: "reject_negotiation"
  delete "/negotiation/:id/deactivate_gig", to: "negotiations#deactivate_gig", as: "deactivate_negotiation_gig"
  delete "/negotiation/:id/deactivate_band", to: "negotiations#deactivate_band", as: "deactivate_negotiation_band"
  get "negotiation/:id/pay", to: "negotiations#pay", as: "pay_negotiation"
end

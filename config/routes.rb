Rails.application.routes.draw do
  devise_for :users
  root to: "gigs#index"
  get "/users/index", to: "users#index", as: "user"
  # gigs paths
  get "/gigs/index", to: "gigs#index", as: "gigs"
  get "/gigs/new", to: "gigs#new", as: "new_gig"
  post "/gigs/", to: "gigs#create", as: "create_gig"
  get "/gigs/:id/edit", to: "gigs#edit", as: "edit_gig"
  patch "/gigs/:id", to: "gigs#update", as: "update_gig"
  get "/gigs/:id/book", to: "negotiations#new", as: "new_negotiation"
  post "gigs/:id/book", to: "negotiations#create", as: "create_negotiation"
  get "/gigs/:id", to: "gigs#show", as: "gig"
  delete "/gigs/:id/delete", to: "gigs#destroy", as: "destroy_gig"
  # bands paths
  get "/bands/new", to: "bands#new", as: "new_band"
  post "/bands/new", to: "bands#create", as: "create_band"
  get "/bands/:id", to: "bands#show", as: "band"
  patch "/bands/:id/edit", to: "bands#edit", as: "edit_band"
  patch "/bands/:id", to: "bands#update", as: "update_band"
  delete "/bands/:id/delete", to: "bands#destroy", as: "destroy_band"
  # negotiations paths
  get "negotiation/:id", to: "negotiations#show", as: "negotiation"
  get "negotiations/:gig_id", to: "negotiations#index", as: "negotiations"
  patch "/negotiation/:id/accept", to: "negotiations#accept", as: "accept_negotiation"
  patch "/negotiation/:id/reject", to: "negotiations#reject", as: "reject_negotiation"
  delete "/negotiation/:id/deactivate_gig", to: "negotiations#deactivate_gig", as: "deactivate_negotiation_gig"
  delete "/negotiation/:id/deactivate_band", to: "negotiations#deactivate_band", as: "deactivate_negotiation_band"
  get "negotiation/success/:id", to: "negotiations#success", as: "payment_sucess"
  get "negotiation/failed/:id", to: "negotiations#failed", as: "payment_failed"
end

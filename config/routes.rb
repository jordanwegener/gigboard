Rails.application.routes.draw do
  # devise_for :users
  # resources :gigs, only: [:create]
  root to: "gigs#index"
  devise_for :users, skip: :all
  devise_scope :user do
    get "/users/sign_in", to: "devise/sessions#new"
    get "/users/sign_out", to: "devise/sessions#destroy"
    post "/users/sign_in", to: "devise/sessions#create"
    delete "/users/sign_out", to: "devise/sessions#destroy"
    get "/users/password/new", to: "devise/passwords#new"
    get "/users/password/edit", to: "devise/passwords#edit"
    patch "/users/password", to: "devise/passwords#update"
    put "/users/password", to: "devise/passwords#update"
    post "/users/password", to: "devise/passwords#create"
    get "/users/cancel", to: "devise/registrations#cancel"
    get "/users/sign_up", to: "devise/registrations#new"
    get "/users/edit", to: "devise/registrations#edit"
    patch "/users", to: "devise/registrations#update"
    put "/users", to: "devise/registrations#update"
    delete "/users", to: "devise/registrations#destroy"
    post "/users", to: "devise/registrations#create"
  end
  get "/users/index", to: "users#index", as: "user"
  get "/gigs/index", to: "gigs#index", as: "gigs"
  get "/gigs/new", to: "gigs#new", as: "new_gig"
  get "/gigs/book", to: "gigs#book", as: "book_gig"
  post "/gigs/", to: "gigs#create", as: "create_gig"
  get "/gigs/:id", to: "gigs#show", as: "gig"
  get "/bands/new", to: "bands#new", as: "new_band"
  get "/bands/:id", to: "bands#show", as: "band"
end

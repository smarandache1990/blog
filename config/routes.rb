Rails.application.routes.draw do
  get 'users/profile'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'u/:id', to: 'users#profile', as: 'user'

  get 'about', to: "pages#about"
  # get "/articles", to: "articles#index"
  # The route above declares that "GET /articles" requests are mapped to the "index" action of "ArticlesController"
  # get "/articles/:id", to: "articles#show"
  # The route above declares that "GET /articles/:id" requests are mapped to the "show" action of "ArticlesController";
  #   where ":id" is a route parameter accessible by the "show" action of "ArticlesController" using params[:id] 
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"

  resources :articles do
    resources :comments
  end
end

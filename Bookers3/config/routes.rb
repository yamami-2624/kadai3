Rails.application.routes.draw do
devise_for :users
  root to: "users#top"
  get "home/about" =>"users#about"
  resources :books
  resources :users, only: [:show, :edit, :update, :index]
end

#     resources :homme do
#     collection do
#     get :about
#   end
# end
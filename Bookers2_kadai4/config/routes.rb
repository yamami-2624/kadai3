# frozen_string_literal: true

Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  # get 'book_comments/create'
  # get 'book_comments/destroy'
  # get 'favorites/creste'
  # get 'favorites/destoroy'
  devise_for :users
  root to: 'users#top'
  get 'home/about' => 'users#about'

  resources :users, only: %i(show edit update index) do
    resource :relationships, only: [:create, :destroy]
    member do
     get :following, :followers
    end
  end

  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments, only: [:create, :destroy]
  end
end

#     resources :homme do
#     collection do
#     get :about
#   end
# end

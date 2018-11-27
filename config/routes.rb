# frozen_string_literal: true

Rails.application.routes.draw do
  resources :advices, except: %i[new edit]
  # RESTful routes
  resources :examples, except: %i[new edit]

  # Custom routes
  # Users
  get '/users/:id' => 'users#getuseradvices'
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out' => 'users#signout'
  patch '/change-password' => 'users#changepw'
  patch '/change-tags' => 'users#change_tags'

  # Advices
  get '/random-advice' => 'advices#getrandom'
  patch 'advices/unapprove/:id' => 'advices#unapprove'

  # Likes
  post '/likes/:id' => 'likes#create'
  delete '/likes/:id' => 'likes#destroy'
end

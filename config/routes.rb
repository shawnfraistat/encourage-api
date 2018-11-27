# frozen_string_literal: true

Rails.application.routes.draw do
  resources :advices, except: %i[new edit update]
  # RESTful routes
  resources :examples, except: %i[new edit]

  # Custom routes
  # Users
  get '/users/:id' => 'users#getuseradvices'
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out' => 'users#signout'
  patch '/change-password' => 'users#changepw'

  # Advices
  get '/random-advice' => 'advices#getrandom'

  # Likes
  post '/likes/:id' => 'likes#create'
  delete '/likes/:id' => 'likes#destroy'
end

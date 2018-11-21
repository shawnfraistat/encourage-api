# frozen_string_literal: true

Rails.application.routes.draw do
  resources :advices, except: %i[new edit]
  # RESTful routes
  resources :examples, except: %i[new edit]

  # Custom routes
  # Users
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out' => 'users#signout'
  patch '/change-password' => 'users#changepw'

  # Advices
  get '/random-advice' => 'advices#getrandom'
end

Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :trainers
  resources :trainers
  patch '/home/capture_path', to: 'pokemons#capture', as: :capture
  patch '/trainers/:id/show/damage_path', to: 'pokemons#damage', as: :damage
  post '/trainers/:id/new', to: 'pokemons#new', as: :new
  resources :pokemons
end

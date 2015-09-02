Rails.application.routes.draw do

  devise_for :admins
  root 'welcome#index'

  devise_for :users, :controllers => { registrations: 'registrations' }
  
  resources :users do
    get "show", on: :collection
    get "stats", on: :collection
  end
  resources :utility_tips do 
    get "electricity", on: :collection
    get "water", on: :collection
    get "natural_gas", on: :collection
  end
  resources :stats

  match "*path" => redirect("/"), via: :get
end

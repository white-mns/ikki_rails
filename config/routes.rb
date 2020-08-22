Rails.application.routes.draw do
  resources :init_equips
  resources :new_skills
  resources :new_embryos
  resources :new_item_fukas
  resources :new_items
  resources :items
  resources :skills
  resources :skill_data
  resources :embryos
  resources :embryo_names
  resources :productions
  resources :statuses
  resources :proper_names
  resources :names
  resources :uploaded_checks
  get 'top_page/privacy'
  root 'top_page#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

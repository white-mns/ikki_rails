Rails.application.routes.draw do
  resources :pk_results
  resources :prizes
  resources :assaults
  resources :pk_data
  resources :new_defeat_enemies
  resources :new_battle_enemies
  resources :duel_results
  resources :battle_results
  get "bosses",  :to => "new_next_enemies#boss",  :as => "bosses"
  resources :new_next_enemies
  resources :next_duel_infos
  resources :next_battle_infos
  resources :next_battle_enemies
  resources :party_infos
  resources :parties
  get "pk_histories",  :to => "current_areas#pk",  :as => "pk_histories"
  get "current_area/totals",  :to => "current_areas#total",  :as => "current_area_totals"
  resources :current_areas
  resources :area_data
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

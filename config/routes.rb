Rails.application.routes.draw do
  get 'home/index'
  get 'admin/index'
  get 'admin/edit'
  patch 'admin/update'
  devise_for :users
  resources :devis_lignes
  resources :facture_lignes
  resources :devis
  resources :factures
  resources :clients
  resources :document_modeles
  resources :devis_statuts
  resources :facture_statuts
  resources :taxes
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  get 'home/index'
  get 'admin/index'
  get 'admin/edit'
  patch 'admin/update'
  devise_for :users
  resources :photos do
    member do
      get 'preview'
    end
  end
  resources :depenses do
    member do
      get 'destroy_attachement'
    end
  end
  resources :devis_lignes
  resources :facture_lignes
  resources :devis do
    member do
      get 'duplicate'
    end
  end
  resources :factures do
    member do
      get 'duplicate'
    end
  end
  resources :clients
  resources :document_modeles
  resources :devis_statuts
  resources :facture_statuts
  resources :taxes
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

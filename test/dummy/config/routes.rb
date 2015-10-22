Rails.application.routes.draw do

          resources :teams
            resources :teams
  get 'teams/index'
  match ":controller(/:action(/:id))", :via=>[:get, :post]
  #mount MptTree::Engine => "/mpt_tree"
end

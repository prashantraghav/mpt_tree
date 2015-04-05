Rails.application.routes.draw do

  get 'teams/index'
  match ":controller(/:action(/:id))", :via=>[:get, :post]
  #mount MptTree::Engine => "/mpt_tree"
end

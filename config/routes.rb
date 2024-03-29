Razzdraft::Application.routes.draw do
  devise_for :admin_users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  devise_for :users
  resources :users, only: [:index]
  # Teams
  match 'baseball_teams/yahoo_league' => 'baseball_teams#yahoo_league', as: 'yahoo_league'
  match 'baseball_teams/espn_league' => 'baseball_teams#espn_league', as: 'espn_league'
  resources :baseball_teams

  # Baseball
  match 'baseball/search' => 'baseball#search', as: 'baseball_search'
  match 'baseball/draft_player/:id' => 'baseball#draft_player', as: 'draft_player'
  match 'baseball/undraft_player/:id' => 'baseball#undraft_player', as: 'undraft_player'
  match 'baseball/remove_player/:id' => 'baseball#remove_player', as: 'remove_player'
  match 'baseball/restore_player/:id' => 'baseball#restore_player', as: 'restore_player'
  match 'baseball/removed_players' => 'baseball#removed_players', as: 'removed_players'
  match '', to: 'projections#index', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }

  match 'show_blurb/:id' => 'projections#show_blurb', as: 'show_blurb'

  root to: "projections#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

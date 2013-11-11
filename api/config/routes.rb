AudioWire::Application.routes.draw do

  root :to => "home#index"

  get "home/index"

  devise_for :users, :skip => [:registrations, :sessions, :passwords]
  as :user do
    post '/api/users' => 'registrations#create'
#    delete '/users' => 'registrations#destroy'
  end
  scope '/api' do
    match '/users/login' => 'tokens#create', :via => :post
    match '/users/logout' => 'tokens#delete', :via => :delete
    match '/users' => 'users#update', :via => :put
    match '/users' => 'users#index', :via => :get
    match '/users/me' => 'users#show_me', :via => :get
    match '/users/:id' => 'users#show', :via => :get
    match 'users/avatar' => 'users#update_avatar', :via => :put


    match '/tracks' => 'tracks#create', :via => :post
    match '/tracks' => 'tracks#list', :via => :get
    match '/tracks' => 'tracks#bulk_delete', :via => :delete

    match '/tracks/:id' => 'tracks#show', :via => :get
    match '/tracks/:id' => 'tracks#delete', :via => :delete
    match '/tracks/:id' => 'tracks#update', :via => :put


    match '/friends' => 'friendships#create', :via => :post
    match '/friends' => 'friendships#index', :via => :get

    match '/friends/:friend' => 'friendships#destroy', :via => :delete


    match '/playlist' => 'playlists#list', :via => :get
    match '/playlist' => 'playlists#create', :via => :post
    match '/playlist' => 'playlists#bulk_delete', :via => :delete

    match '/playlist/:id' => 'playlists#delete', :via => :delete
    match '/playlist/:id' => 'playlists#show', :via => :get
    match '/playlist/:id' => 'playlists#update', :via => :put

    match '/playlist/:id/tracks' => 'playlists#get_tracks', :via => :get
    match '/playlist/:id/tracks' => 'playlists#add_tracks', :via => :post
    match '/playlist/:id/tracks' => 'playlists#bulk_delete_tracks', :via => :delete

    match '/playlist/:id/tracks/:id_track' => 'playlists#delete_track', :via => :delete
  end

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

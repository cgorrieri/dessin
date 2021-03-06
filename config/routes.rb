Dessin::Application.routes.draw do

  resources :informations,
    :path => "news",
    :path_names => { :new => 'creer-une-news', :edit => 'modifier-une-news' }

  resources :gallery_categories

  resources :galleries,
    :path => "galerie" do
    resources :medias
    resources :galleries_comment
    member do
      post :add_media
      get :remove_media
      post :add_comment
    end
  end

  devise_path_names = { :sign_in => 'connexion',
    :sign_out => 'deconnexion',
    :password => 'identifiants',
    :confirmation => 'verification',
    :sign_up => 'inscription' }

  devise_for :users,
    :path => "compte",
    :path_names => devise_path_names,
    :controllers => { :registrations => "users/registrations", :sessions => "users/sessions" } do
      get "/compte/mes-donnees-personnelles" => "users/registrations#edit", :as => :private_datas_user
    end

  match '/les-membres/membre/:id' => 'users#show', :as => :user
  match '/les-membres' => 'users#index', :as => :users
  match '/compte/mes-galeries' => 'users#galleries', :as => :galleries_user
  match '/compte/accepter-demande-amis/:id' => 'users#add_friend', :as => :add_friend_user
  match '/compte/supprimer-amis/:id' => 'users#remove_friend', :as => :remove_friend_user
  match '/compte/demande-amis/:id' => 'users#send_friend_request', :as => :send_friend_request
  match '/compte/refuser-demande-amis/:id' => 'users#remove_friend_request', :as => :remove_friend_request_user
  match '/compte/les-demande-amis' => 'users#friend_requests', :as => :friend_requests_user
  match '/compte/mes-amis' => 'users#friends', :as => :friends_user
  match '/compte/envoyer-un-message/:id' => 'users#send_message', :as => :send_message_user
  match '/compte/supprimer-message/:id' => 'users#remove_message', :as => :remove_message_user
  match '/compte/mes-messages' => 'users#messages_recieved', :as => :messages_recieved_user
  match '/compte/les-nouveau-commentaires' => 'users#galleries_commented', :as => :galleries_commented_user
  match '/compte/supprimer-commentaire/:id' => 'users#remove_gallery_comment', :as => :remove_gallery_comment_user
  
  root :to => "home#index"

  resources :forum_parts

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

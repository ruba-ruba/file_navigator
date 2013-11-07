require 'sidekiq/web'

FileNavigator::Application.routes.draw do

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  resources :sessions
  resources :users do 
    get 'file_review', to: 'users#file_review', on: :collection
  end

  root to: 'folders#index'

  resources :items do
    resources :comments
    post 'multi_create', to: 'items#multi_create', on: :collection
    collection do
      delete 'destroy_by_type'
    end
    post 'update_duplicate_condition', to: 'items#update_duplicate_condition', on: :member
  end
  
  get 'download_file', to: 'folders#download_file'
  get 'download_folder', to: 'folders#download_folder'  
  resources :folders do
    get 'info', to: 'folders#folder_info', on: :member
    get 'drop', to: 'folders#drop', on: :collection
    resources :comments
    collection do
      delete 'destroy_multiple'
    end
  end

  #grape
  mount MyApp::API => "/"
  #sidekiq
  mount Sidekiq::Web, at: "/sidekiq"


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

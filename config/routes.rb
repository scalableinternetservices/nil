Rails.application.routes.draw do
  get 'restaurants/setting'   => 'restaurants#edit'
  get 'customers/setting'     => 'customers#edit'
  get 'shippers/setting'      => 'shippers#edit'
  get 'customers/order'       => 'orders#index_customers'
  get 'customers/order/:id'   => 'orders#show_customers'
  get 'orders/new'            => 'orders#new'
  get 'orders/addtocart/:id'  => 'orders#addtocart'
  get 'orders/clearcart'      => 'orders#clearcart'
  get 'orders/pay/:id'        => 'orders#pay'
  get 'orders/confirmed/:id'  => 'orders#confirmed'
  get 'orders/ready/:id'      => 'orders#ready'
  get 'orders/:id/take'       => 'orders#take'
  get 'restaurants/order'     => 'orders#index_restaurants'
  get 'restaurants/order/:id' => 'orders#show_restaurants'
  get 'restaurants/menu'     => 'foods#index_restaurants'
  #get 'restaurants/:id'       => 'foods#index'
  get 'restaurants/show'      => 'restaurants#show'
  get 'shippers/orders'       => 'shippers#showOrders'
  #get '/restaurant/:restaurant_id/:id' => 'foods#show'
  get 'foods/new' => 'foods#new'
  resources :shippers
  resources :orders
  resources :restaurants do
    resources :foods
    resources :comments
  end
  resources :customers
  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions"}
  devise_scope :user do
    root "users/sessions#new"
  end
  get 'search' => 'searches#search'
 # resources :foods, only: [:index, :show]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

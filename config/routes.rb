Easycount::Application.routes.draw do
  resources :sessions, only: [:create, :destroy]
  resources :users do
    resources :companies
  end
  root 'pages#index'

  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/:id/change_password', to: 'users#change_password', via: 'get', as: :change_password
  match '/:id/update_password', to: 'users#update_password', via: 'put', as: :update_password
  match '/user/:user_id/select/:company_id', to: 'companies#select', via: 'post', as: :select_company
  match '/dashboard', to: 'pages#dashboard', via: 'get', as: :dashboard
  match '/users/:user_id/companies/:id', to: 'companies#destroy', via: 'delete', as: :destroy_company
  match '/users/:user_id/companies_continue/:id', to: 'companies#create_company_data', via: 'put', as: :create_company_data
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

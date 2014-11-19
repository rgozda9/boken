Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :categories

  root to: 'welcome#index'

  get '/', to: 'welcome#index', as: 'boken'

  get 'reset_filterrific', to: 'welcome#reset_filterrific', as: 'reset_filterrific_products'

  get 'products/:id/checkout', to: 'products#checkout', as: 'single_checkout'

  get 'products/checkout', to: 'products#checkout', as: 'checkout'

  get 'sign_up', to: 'customers#new', as: 'sign_up'

  get 'login', to: 'customers#login', as: 'login'

  get 'contact', to: 'admin/contact#edit', as: 'edit_contact'

  post 'login', to: 'customers#login'

  resources :line_items

  resources :orders

  resources :customers do
    member do
      get 'add_to_session'
    end
  end

  resources :provinces

  resources :products do
    member do
      get 'add_to_session'
    end
  end

  resources :ratings, only: :update

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

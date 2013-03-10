Pject::Application.routes.draw do


  get 'tags/:tag', to: 'documents#index', as: :tag
  get 'video_tags/:tag', to: 'videos#index', as: :video_tags
  get 'post_tags/:tag', to: 'posts#index', as: :post_tags

  resources :day_offs
  resources :documents
  resources :parts
  resources :bugs
  resources :updates
  resources :options
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :workorders
  resources :comments
  resources :emails, only: [:new, :create, :destroy, :index]
  resources :off_days

  resources :posts do
    resources :comments
  end

  resources :workorders do
    resources :comments
  end
  resources :documents do
    resources :comments
  end

  resources :videos do
    resources :comments
  end

  resources :videos do
    new do
        post :upload
        get :save_video
    end
  end

  root to: 'static_pages#home'

  match '/help', to: 'static_pages#help'
  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/rebuilder', to: 'static_pages#rebuilder_view'
  match '/branchmanager', to: 'static_pages#home'
  match '/welcome', to: 'static_pages#home'
  match '/calendar', to: 'workorders#calendar'
  match '/lp', to: 'static_pages#landing_page'

  match '/calendar_feed/:id/calendar_feed', to: 'workorders#calendar_feed', :as => 'calendar_feed_path'
  match '/time_off_feed/:id/time_off_feed', to: 'day_offs#time_off_feed', :as => 'time_off_feed_path'

  match '/switchbranch', to: 'users#user_branch_switch'

  match 'toggle_mobile', to: 'static_pages#toggle_mobile', :as => "toggle_mobile"
  match 'toggle_normal', to: 'static_pages#toggle_normal', :as => "toggle_normal"


  match 'workorders/:id/complete', to: 'workorders#complete', :as => "complete_workorder"
  match 'bugs/:id/complete', to: 'bugs#complete', :as => "complete_bug"
  match 'parts/:id/ordered', to: 'parts#ordered', :as => "ordered_part"
  match 'documents/:id/email', to: 'documents#email', :as => 'email_document_path'

  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/search', to: 'workorders#index'
  match '/open', to: 'workorders#open', :as => 'open_workorders_path'
  match '/pastdue', to: 'workorders#past_due', :as => 'pastdue_workorders_path'
  match '/unassigned', to: 'workorders#unassigned', :as => 'unassigned_path'
  match '/need_to_order', to: 'workorders#need_to_order', :as => 'need_to_order_path'
  match '/timeoff', to: 'workorders#timeoff', :as => 'timeoff'

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

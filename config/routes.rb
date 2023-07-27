Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # get 'welcome/index
  resources :users do
    collection do
      get :state
      get :city
    end
  end
  resources :books do
    collection do
      # get :book_list
      # get :book_issue_requests
      post :upload
      get :export_file
    end
    member do
      # get :book_detail
      get :book_issue_request
      get :book_return_request
    end
  end
 

  resources :students do
    collection do
      get :profile
      get :my_history
    end
  end
  # resources :librarians

  resources :librarians do
    collection do
      get :profile
      get :get_books_for_approval
      get :message_broadcast
      get :message_job
    end
    member do
      get :approve
      get :ignore
    end
  end
  resources :payments
  mount ActionCable.server => '/cable'
end

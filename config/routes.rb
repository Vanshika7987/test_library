Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # get 'welcome/index
  resources :users
  resources :books do
    collection do
      # get :book_list
      # get :book_issue_requests
    end
  end
  resources :books do
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
    end
  end
  resources :librarians do
    member do
      get :approve
      get :ignore
    end
  end
end

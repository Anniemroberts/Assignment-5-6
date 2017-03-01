Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  get '/' => 'posts#index'
  get '/blog/index' => 'blog#index'


  resources :posts, shallow: true do
    resources :comments
  end

   resources :users, only: [:new, :create, :edit, :update]
  # resource :resetpass, only: [:edit] do
  # collection do
  #   patch 'update_password', :action => :update_password
  #   end
  # end
  resources :resetpass, only: [:edit] do
    collection do
      patch :update_password
    end
  end
  
  resources :sessions, only: [:new, :create, :destroy] do
     delete :destroy, on: :collection
  end

end

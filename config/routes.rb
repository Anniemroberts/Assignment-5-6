Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/' => 'posts#index'
  get '/blog/index' => 'blog#index'


  # shallow: true option makes it so nested routes only include '/questions/:question_id'
  # for the create action and not for `destroy` for instance. This is because
  # when deleting a nested resouces you may not need to know about the parent
  # resource because you can get it from the Database. In our case, we can
  # get the question_id of an answer from the databse

  resources :posts, shallow: true do
    resources :comments, only: [:create, :destroy]
  end

end

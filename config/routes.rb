Rails.application.routes.draw do



  #管理者用
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  get 'admin' => 'admin/homes#top'
  namespace :admin do
    resources :posts, only: [:show, :edit, :update, :destroy, :index] do
     resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update]
  end

  #ユーザー
  devise_for :user, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
   }

  scope module: :public do
    resources :users, only: [:show]
    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
     resources :post_comments, only: [:create, :destroy]
     resources :bookmarks, only: [:create, :destroy, :index]
    end
    get '/user/information/edit' => 'users#edit'
    patch '/user/information' => 'users#update'
    get 'search' => 'posts#search'
    get '/search_tag' => 'posts#search_tag'
  end

  namespace :public do
    get 'post_comments/create'
    get 'post_comments/destroy'
  end
  #get 'post_comments/create'
  #get 'post_comments/destroy'



  #ゲストユーザーログイン
 devise_scope :user do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'

  end

  root to: 'public/homes#top'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

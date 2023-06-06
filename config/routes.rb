Rails.application.routes.draw do
  
  ## ゲスト（閲覧用）
  devise_scope :end_user do
    post 'end_users/guest_sign_in', to: 'end_users/sessions#guest_sign_in', as: 'guest_sign_in'
  end
  
  
  ## 会員側
  # URL /end_users/sign_in ...
  
  # skip: [:passwords]で、パスワード変更のルーティングを削除
  devise_for :end_users, skip: [:passwords], controllers: {
    registrations: "public/registrations",  #新規登録
    sessions: 'public/sessions'  #ログイン
  }

  root to: 'public/homes#top'
  get 'about', to: 'public/homes#about', as: 'about'

  scope module: :public do

    ## end_users
    patch 'end_users/:id' => 'end_users#update', as: 'update_end_user'
    patch 'end_users/resign' => 'end_users#resign', as: 'resign_end_user'
    get 'favorites' => 'end_users#index_favorites', as: 'index_favorites'
    get 'end_users/confirm' => 'end_users#confirm', as: 'confirm_resign'
    resources :end_users, only: [:index, :show, :edit] do
      
      # relationships
      post 'relationships' => 'relationships#create', as: 'create_relationship'
      delete 'relationships' => 'relationships#destroy', as: 'destroy_relationship'
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end

    ## posts
    patch 'posts/:id' => 'posts#update', as: 'update_post'
    delete 'posts/:id' => 'posts#destroy', as: 'destroy_post'
    resources :posts, only: [:new, :show] do
      
      # post_comments
      post 'comments/new' => 'post_comments#create', as: 'create_comment'
      delete 'comments/:id' => 'post_comments#destroy', as: 'destroy_comment'
      
      # favorites
      post 'favorites' => 'favorites#create', as: 'create_favorite'
      delete 'favorites' => 'favorites#destroy', as: 'destroy_favorite'
      # resource :favorites, only: [:create, :destroy]  #resource(単数)だとURLにidが入らない
    end
    
    ## searches
    get "search" => "searches#search"
  end
  
  
  ## 管理者側
  # URL /admin/sign_in ...
  
  # skip: ... で不要なルーティングを削除
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"  #ログイン
  }  

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    
    ## end_users
    patch 'end_users/:id' => 'end_users#update'
    resources :end_users, only: [:show]
    
    ## posts
    delete 'posts/:id' => 'posts#destroy', as: 'destroy_post'
    resources :posts, only: [:show]
  end
end 

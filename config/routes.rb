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
    patch 'end_users/resign' => 'end_users#resign', as: 'resign_end_user'
    get 'favorites' => 'end_users#index_favorites', as: 'index_favorites'
    get 'end_users/confirm' => 'end_users#confirm', as: 'confirm_resign'
    resources :end_users, only: [:index, :show, :edit, :update] do
      
      ## relationships
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end

    ## posts
    resources :posts, only: [:new, :create, :destroy, :show, :edit, :update] do
      
      ## post_comments
      resources :post_comments, only: [:create, :destroy]
      
      ## favorites
      resource :favorites, only: [:create, :destroy]
      get 'favorites' => 'favorites#index', as: 'index_my_favorite'
      # resource(単数)だとURLにidが入らない＝1つの投稿に対して1回しかいいねできない
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
    resources :end_users, only: [:show, :update]
    
    ## posts
    resources :posts, only: [:show, :destroy]
  end
end 

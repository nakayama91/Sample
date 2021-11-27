Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords,], controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  #customer側↓

  scope module: :customer do
    #ホーム画面ルーティング
    root to: 'homes#top'
    get 'home/about' => 'homes#about'

    #カスタマー
    resource :customers, only: [:edit, :update]
      get 'customers/my_page' => 'customers#show'
      get 'customers/leave' => 'customers#leave'
      patch 'customers/withdraw' => 'customers#withdraw'

    #商品
    resources :products, only: [:index, :show] do
      collection do
        get 'genre_search' => 'products#search'
      end
    end

    #配送先
    resources :shipping_addresses, only: [:index, :create, :edit, :update, :destroy]

    #注文
    resources :orders, only: [:index, :show, :create, :new] do
      get 'complete',   on: :collection
      post 'confirm', on: :collection
    end

    #カート商品
    resources :cart_products, only:[:index, :destroy, :edit, :update, :create] do
      collection do
        delete 'cart_products/destroy_all' => 'cart_products#destroy_all'
      end
    end

  end

end

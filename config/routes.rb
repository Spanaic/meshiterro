Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'post_images#index'
  # deviseの機能としてログイン認証が完了したら、rootパスへリダイレクトされるようになっている
  resources :post_images, only: [:new, :create, :show, :index] do
  # ルーティングのresourcesは複数形
  # only:オプションなので、しっかりとコロンを記述すること
    resource :post_comments, only: [:create, :destroy]
    # resourceが単数形だと、post_commentsコントローラのidが作成されない　＝＞コメントの詳細ページが必要ない（画像投稿の詳細ページに直接表示させる）
    resource :favorites, only: [:create, :destroy]
  end
  # ルーティング時にresourcesをネストする場合はdoで始めて、endで終わる
end
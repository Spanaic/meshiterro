class FavoritesController < ApplicationController
    def create
        post_image = PostImage.find(params[:post_image_id])
        # favorite = current_user.favorites.new(favorite_params)
        # ストロングパラメータを通したのは間違い。なぜなら今回はform_forヘルパーを使ってないから。
        # リダイレクトするので変数はローカルでオッケ
        favorite = current_user.favorites.new(post_image_id: post_image.id)
        # 現在ログインしているユーザのいいね情報を、favoritesモデルに入力していく
        # アソシエーションさせるために、favoritesのpost_image_idとそれに対応するpost_imageのidカラムを紐付ける

        # favorite.user_id = post_image.user_id
        # 変数favoriteに値を代入した際にidの紐付けが行われたため、改めてidを紐付ける必要がなくなったので不要
        favorite.save
        redirect_to post_image_path(post_image)
        # 引数内の変数もローカル変数で定義されているのでローカルでオッケ
    end

    def destroy
        post_image = PostImage.find(params[:post_image_id])

        # post_image.id = current_user.favorites.post_image_id
        # 上記だと変数favoriteが定義されていないのでdestroyメソッドが有効にならない
        # favorite = current_user.post_image.id.find_by(:post_image_id)

        favorite = current_user.favorites.find_by(post_image_id: post_image.id)
        # favoriteとはなんですか？現在ログインしているユーザ情報をfavoritesから見つけて下さい。条件は（favoriteのid:と親モデルの.id）ですよ
        # find_byメソッドは各モデルを複数条件下で検索できる。
        # 返ってくる値は最初にヒットした1件
        # findメソッドはidで検索する
        # whereは後ほど…
        favorite.destroy
        redirect_to post_image_path(post_image)
    end

    # private
    # def favorite_params
    #     params.require(:favorite).permit(:user_id, :post_image_id)
    # end
    # form_for使ってないから要らなかった
end

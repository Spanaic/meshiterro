class PostImagesController < ApplicationController

    def index
        # @post_images = PostImage.all
        @post_images = PostImage.page(params[:page]).reverse_order
        #　kaminari導入後はindexの変数に代入する値をページネーション用に書き換える
    end

    def new
        @post_image = PostImage.new
        # @post_image = Post_image.new
        # モデルクラス名は複数単語で構成される場合は単語の頭文字を大文字にする
    end

    def create
        @post_image = PostImage.new(post_image_params)
        @post_image.user_id = current_user.id
        # @post_image.user_idにcurrent_user.id(アソシエーションで紐付いたidのこと)を代入する =>書き換えるものではないのでストロングパラメータは必要ない
        if @post_image.save

            redirect_to post_images_path
        else
            # redirect_to new_post_image_path
            render :new
        end
        #　saveメソッドは変数に対して行われている
    end

    def show
        @post_image = PostImage.find(params[:id])
        @post_comment = PostComment.new
        # コメントを作成するときのform_forヘルパーに代入するインスタンス変数として記述
        # @post_commentの変数には PostCommentモデルで作成された空のレコードを代入する。PostImageのモデルに空のレコードをnewしてもcommentの値を入れるカラムが存在しない。
        # @post_image.user.id = current_user.id
    end

    def destroy
        post_image = PostImage.find(params[:id])
        post_image.destroy
        # ローカル変数とインスタンス変数の特徴としては、1.インスタンス変数はviewに渡せる以外にも、外部から参照できるという特徴がある
        # 今回はカリキュラム内容としてインスタンス変数が使用されているが、将来的なことを考えるとviewに渡さないような場合はローカルにしておいた方が無難
        redirect_to post_images_path
    end

    private
    def post_image_params
        params.require(:post_image).permit(:shop_name, :caption, :image)
        # requireには（:モデル名[小文字単数]）を指定する
        # ()()paramsは丸括弧二回
        # permitする時は、image"_id"の部分を除く
        # user_idはpermitしなくて良い
    end
end

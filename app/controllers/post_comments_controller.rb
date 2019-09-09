class PostCommentsController < ApplicationController
    def create
        post_image = PostImage.find(params[:post_image_id])
        # ？？ここの一連の流れを教えていただく
        comment = current_user.post_comments.new(post_comment_params)
        # 現在サインインしているユーザのpost_commentsの空のレコードに、form_forメソッドで入力された値を渡す。
        # form_forを通してモデルに渡すため、ストロングパラメータを通す
        # 変数commentはviewに渡されているというより、下の変数に代入されたpost_image_idを取り出すために使われている
        comment.post_image_id = post_image.id
        # 変数commentに代入されているログイン中のユーザのid(post_image_id)は、変数post_imageのidと等しい。ということを定義する
        comment.save
        # 変数commentをsaveする
        redirect_to post_image_path(post_image)

    end

    def destroy

    end

    private
    def post_comment_params
        params.require(:post_comment).permit(:comment,:user_id, :post_image_id)
        # requireするのは小文字単数のモデル名
    end
end

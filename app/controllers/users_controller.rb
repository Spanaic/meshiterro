class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # findメソッドやpageメソッドでは(params[:id])を用いて参照にする
    @post_images = @user.post_images.page(params[:page]).reverse_order
  end

  def edit
    # @post_image = PostImage.find(params[:id])
    # 上記の設定だと編集するのは投稿画像の詳細になってしまうのでNG
    @user = User.find(params[:id])
end

def update
  user = User.find(params[:id])
  user.update(user_params)
  redirect_to user_path(user.id)
end

private
def user_params
  params.require(:user).permit(:name, :profile_image,)
end

end

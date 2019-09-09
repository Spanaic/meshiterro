class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # findメソッドやpageメソッドでは(params[:id])を用いて参照にする
    @post_images = @user.post_images.page(params[:page]).reverse_order
  end
end

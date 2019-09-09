class ApplicationController < ActionController::Base
   
     before_action :configure_permitted_parameters, if:  :devise_controller?
    #  アクション（devise利用の機能）が実行される前に :configure_permitted_parametersが実行される

    before_action :authenticate_user!
    # devise側のメソッドでログイン認証していなければ、ログイン画面へリダイレクトさせる機能
    # ログイン済みのユーザのみにアクセスを許可する


     protected
    # privateのようなポジションで使われるやつ
    # 

    def configure_permitted_parameters 
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

end

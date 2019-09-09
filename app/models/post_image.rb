class PostImage < ApplicationRecord

    belongs_to :user
    attachment :image

    has_many :post_comments, dependent:  :destroy
    has_many :favorites, dependent:  :destroy

    validates :shop_name, presence: true
    validates :image, presence: true
    # imageを指定するときに”_id”は不要

    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
        # viewの作成で後ほど利用
        # 引数で渡されたuser_idが”Favorites"テーブル内に存在するかを調べるメソッド
        # 存在すればtrue,存在しなければfalseを返す
    end
end

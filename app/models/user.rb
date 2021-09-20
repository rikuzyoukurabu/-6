class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  
  has_many :books,dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
#   コメントとuserはn:1となるため
has_many :relationships, foreign_key: :following_id
# フォローする側から伸びている
has_many :folloeing, through: :relationships, source: :follower
has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id
has_many :followers, through: :renerse_of_relationships, source: :folloeing
# user側で2回書いたのでここでもhas_manyを書くということ
   def already_favorited?(book)
     self.favorites.exists?(book_id: book.id)
   end

  validates :name, presence: true,length: { in: 2..20 }
  validates :introduction, length: {maximum: 50}
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end

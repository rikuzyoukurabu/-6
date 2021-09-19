class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  
  has_many :books,dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments,dependent: :destroy
#   コメントとuserはn:1となるため
   def already_favorited?(book)
     self.favorites.exists?(book_id: book.id)
   end

  validates :name, presence: true,length: { in: 2..20 }
  validates :introduction, length: {maximum: 50}
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end

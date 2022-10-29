class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search(search, word)
    if search == "perfect"
        @book = Book.where("title LIKE?","#{word}")
    elsif search == "partial"
        @book = Book.where("title LIKE?","%#{word}%")
    elsif search == "forward"
        @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward"
        @book = Book.where("title LIKE?","%#{word}")
    else
        @book = Book.all
    end
  end

end

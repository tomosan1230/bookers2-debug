class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :view_counts, dependent: :destroy

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  is_impressionable

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

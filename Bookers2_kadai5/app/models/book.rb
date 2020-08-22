# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comment, dependent: :destroy
  has_many :favorite, dependent: :destroy

  validates :title, presence: true

  validates :body, presence: true,
                   length: { maximum: 200 }
  # length: { in: 0..75 }

   def favorited_by?(user)
    favorite.where(user_id: user.id).exists?
  end

  def self.search(search, word)
        if search == "forward_match"
                        @book = Book.where("title LIKE?","#{word}%")
        elsif search == "backward_match"
                        @book = Book.where("title LIKE?","%#{word}")
        elsif search == "perfect_match"
                        @book = Book.where("#{word}")
        elsif search == "partial_match"
                        @book = Book.where("title LIKE?","%#{word}%")
        else
                        @book = Book.all
        end
end
end

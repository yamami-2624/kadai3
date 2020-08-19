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
end

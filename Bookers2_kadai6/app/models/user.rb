# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorite, dependent: :destroy
 # フォロー機能
  # has_many :relationships
  # has_many :followings, through: :relationships, source: :follow
  # has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  # has_many :followers, through: :reverse_of_relationships, source: :user
  attachment :profile_image

  validates :name, presence: true,
                   length: { minimum: 3, maximum: 20 }

  validates :introduction, length: { maximum: 50 }





  #フォロー機能２ フォローできる人間を取り出す
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy

  has_many :followings, through: :following_relationships

  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy

  has_many :followers, through: :follower_relationships

  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

def self.search(search,word)
        if search == "forward_match"
                        @user = User.where("name LIKE?","#{word}%")
        elsif search == "backward_match"
                        @user = User.where("name LIKE?","%#{word}")
        elsif search == "perfect_match"
                        @user = User.where("#{word}")
        elsif search == "partial_match"
                        @user = User.where("name LIKE?","%#{word}%")
        else
                        @user = User.all
        end
  end
end

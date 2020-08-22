class SearchForm
  include ActiveModel::Model

  attr_accessor :range
  validates :range, presence: true

  attr_accessor :search
  validates :search, presence: true

  attr_accessor :word
  validates :word, presence: true
end
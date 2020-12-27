class Article < ApplicationRecord

  has_many :browsing_histories, dependent: :destroy
  belongs_to :user
end

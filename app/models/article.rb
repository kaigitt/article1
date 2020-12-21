class Article < ApplicationRecord

  has_many :browsing_histories, dependent: :destroy
end

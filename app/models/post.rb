
class Post < ApplicationRecord
  validates_presence_of :title, :url, presence: true
end

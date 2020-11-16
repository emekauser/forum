class Post < ApplicationRecord
    has_many :comments, dependent: :destroy

    validates :title, length: { minimum: 4}
    validates :content, length: { minimum: 4}
    validates :title_link, length: { minimum: 4}
    validates_presence_of :title, :title_link, :content
end

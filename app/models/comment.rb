class Comment < ApplicationRecord
    belongs_to :post
    
    validates :message, length: { minimum: 4}
    validates :message, length: { maximum: 500}
    validates_presence_of :message
end

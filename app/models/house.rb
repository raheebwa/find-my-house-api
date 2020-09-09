class House < ApplicationRecord
    has_many :favourites, dependent: :destroy
    has_many :users, through: :favourites
    validates_presence_of :name, :description, :image_url, :price
end

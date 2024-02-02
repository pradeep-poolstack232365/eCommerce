class Cart < ApplicationRecord
	belongs_to :user
	has_and_belongs_to_many :products
	has_one_attached :image
end

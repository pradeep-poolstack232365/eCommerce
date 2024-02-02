class Address < ApplicationRecord
	has_many :orders, dependent: :destroy
	belongs_to :user
	has_one_attached :image

	# has_and_belongs_to_many :products
end

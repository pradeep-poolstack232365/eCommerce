class Product < ApplicationRecord
	self.table_name = "products"
	
	has_one_attached :image
end



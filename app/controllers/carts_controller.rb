class CartsController < ApplicationController
     before_action :authenticate_request
	def add_product
		# debugger
		cart = @current_user.cart.products
		select_product = Product.find(params[:id])

		if cart.include?(select_product)
		   render json: {message: "product has already added to your cart"}
		else
		   cart.push(select_product)
		   render json: {message: "product has been added successfully"}
		end
	end

	def remove_product
	# debugger
     cart = @current_user.cart.products
     product = Product.find(params[:id])
      if product.present?
      	cart.delete(product)
     	render json: {message: "product has been removed successfully from cart"}
      else
     	render json: {message: "product not found #{params[:id]}"}
	 end
     end
end

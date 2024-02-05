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
	 # byebug
	 unless @current_user
	 	render json: {error: "User not authenticated"}, status: :unauthorized
	 	return
	 end

	 unless @current_user.cart
	 	render json: {error: "user doest not have a cart"}, status: :unprocessable_entity
	 	return 
	 end

      product = Product.find_by(id: params[:id])

      if product
      	cart = @current_user.cart
      	 if cart.products.include?(product)
      	 	cart.products.delete(product)
      	 	render json: {message: "product has removed successfully from the cart"}
      	 else
      	 	render json: {error: "product not found in the cart"}, status: :unprocessable_entity
      	 end
      else
      	render json: {error: "product not found"}, status: :not_found
      end

     end

end

class OrdersController < ApplicationController
     require 'securerandom'
     before_action :authenticate_request
       
     def index
      # byebug
        @orders = Order.all
        render json: @orders, each_serializer: OrderSerializer
     end 

     def show 
      # byebug
       # @order = Order.find_by(id: params[:id]
      @order = @current_user.orders.find_by(id: params[:id])
       if @order.present?
        render json: @order, each_serializer: OrderSerializer
       else
        render json: {error: "Order not found"}, status: :unauthorized
       end
     end  

     def create
     	# byebug
     	@products = @current_user.cart.products
     	order = Order.new(
     		  	   user_id: @current_user.id,
     		       order_number: generate_order_number,
                   total_mrp: calculate_total_mrp, 
                   total_price: calculate_total_price, 
                   discount: calculate_discount,
                   tax: calculate_tax,
                   payment_method: params[:payment_method],
                   address_id: params[:address_id]   
                   )
         # debugger
     	    if order.save
                order.products << @products
                @products.destroy_all


     		   render json: { message: 'Order placed successfully', order: order }
     	    else
     		   render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
            end
     end



       private
          def generate_order_number
            # order_number = 5.times.map { [*0..9   ].sample }.join.to_i
              order_number = SecureRandom.hex(3).to_i(16) % 1_000_000
              if @order && @order.respond_to?(:number)
              
               self.class.find_by(order_number: @order.number) ? 
               generate_order_number : order_number

              else
                order_number
              end 
          end

        # def generate_order_number
        #       order_number = SecureRandom.hex(3).to_i(16) % 1_000_000

        #        # Ensure that the order_number is unique
        #       existing_order = Order.find_by(order_number: order_number)
        #        if existing_order
        #         generate_order_number  # Recursively call the method until a unique order_number is generated
        #          else
        #            order_number
        #         end
        # end


	     def calculate_total_mrp
            # @cart = Cart.find_by(id: params[:cart_id])
            # return 0 if @cart.nil?
	        @total_mrp = @products.sum(:mrp)
	         # @cart.products.each { |product| @order.products << product }
             return @total_mrp
	     end

         def calculate_total_price
            # @cart = Cart.find_by(id: params[:cart_id])
            # return 0 if @cart.nil?
            @total_price = @products.sum(:price)
            return @total_price

         end

         def calculate_discount

         	total_mrp = calculate_total_mrp
         	total_price = calculate_total_price

         	discount_percentage = 100.0

         	discount_amount = ((total_mrp - total_price)*(discount_percentage/100)).round(2)

#             for check discount amount not negative 
         	discount_amount = [discount_amount,0].max

         	discount_amount

         end

         def calculate_tax
         	tax_percentage = 5.0
         	total_price = calculate_total_price

         	tax_amount = (total_price * (tax_percentage/100)).round(2)

         	tax_amount

         end
end

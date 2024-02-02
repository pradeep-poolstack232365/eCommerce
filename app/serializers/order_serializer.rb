class OrderSerializer < ActiveModel::Serializer
  
    attributes :user_id, :order_number, :total_mrp, :total_price, :discount, :tax, :payment_method, :address_id, :status
     
     
end
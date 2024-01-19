class ProductsController < ApplicationController
  before_action :authenticate_request 

  def index
    # debugger
    @products = Product.all
     render json: @products, each_serializer: ProductSerializer
  end

  def show
    # debugger
    @product = Product.find_by(id: params[:id])
     render json: @product, each_serializer: ProductSerializer
  end

end

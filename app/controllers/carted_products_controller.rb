class CartedProductsController < ApplicationController
  def index
    @carted_products = CartedProduct.all 
    render :index
  end

  def create
    @carted_product = CartedProduct.create(
      user_id: params[:user_id],
      product_id: params[:product_id],
      order_id: params[:order_id],
      status: params[:status],
    )
    render :show
  end

end

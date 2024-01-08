class OrdersController < ApplicationController
  before_action :authenticate_user

  def create
    if current_user 
      product = Product.find_by(id: params[:product_id])
      @order = Order.new(
        user_id: current_user.id,
        product_id: product.id, 
        quantity: params[:quantity],
        subtotal: product.price,
        tax: product.tax,
        total: (product.price + product.tax) * params[:quantity].to_i
      )
      if @order.save
        # render json: {message: "order submitted"}
        render template: "orders/show"
     
      else
        render json: {message: "order not submitted"}
      end
    else
      render json: {message: "You must be logged in to place an order."}
    end
  end

  def show
    if current_user 
      @order = Order.find_by(id: params[:id])
      render template: "orders/show"
    # render json: {message: "show order"}
    else 
      render json: {message: "You must be logged in to view your orders"}
    end
  end

  def index
    if current_user 
      # @orders = Order.all
      @orders = current_user.orders
      render template: "orders/index"
    else
      render json: {message: "You must be logged in to view your orders"}
    end
  
  end
end

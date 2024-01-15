class OrdersController < ApplicationController
  before_action :authenticate_user

  def create
    if current_user 
      # product = Product.find_by(id: params[:product_id])
      carted_products = CartedProduct.where(user_id: current_user.id, status: "carted")
    
      if carted_products.empty?
        render json: {message: "Your cart is empty."}
        return
      end

      subtotal = 0
      carted_products.each do |carted_product|
        subtotal += carted_product.product.price * carted_product.quantity
      end

      tax = subtotal * 0.09
      total = subtotal + tax


      @order = Order.new(
        user_id: current_user.id,
        # product_id: product.id, 
        # subtotal: product.price,
        # tax: product.tax,
        subtotal: subtotal,
        tax: tax,
        total: total,
        # total: (product.price + product.tax) * params[:quantity].to_i
      )
      if @order.save
        # render json: {message: "order submitted"}
        carted_products.each do |carted_product|
          carted_product.status = "purchased"
          carted_product.order_id = @order.id
          carted_product.save
        end
        render template: "orders/show"

      else
        render json: {message: @order.error.full_message}
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


# def create 
#   @order = Order.new(
#     user_id: 1,
#     subtotal: 10,
#     tax: 10,
#     total: 10,
#   )
#   @order.save!
#   render :show
# end


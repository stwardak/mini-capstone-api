class ProductsController < ApplicationController

  # protect_from_forgery with: :exception, unless: -> { request.format.json? }
  before_action :authenticate_admin, except: [:show, :index]
  
  def index
    @products = Product.all
    render template: "products/index"
  end

  def show
    @product = Product.find_by(id: params[:id])
    render template: "products/show"
  end

  def create

    supplier = Supplier.find_by(name: params[:supplier])

    @product = Product.new(
      name: params[:name],
      price: params[:price],
      description: params[:description],
      # supplier_id: params[:supplier_id],
      supplier_id: supplier.id,
    )
    if @product.save
      render template: "products/show"
    else
      render json: {errors: @product.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.name = params[:name] || @product.name
    @product.price = params[:price] || @product.price
    @product.description = params[:description] || @product.description
    @product.supplier_id = params[:supplier_id] || @product.supplier_id
    @product.images = params[:images] || @product.images
    if @product.save
      render template: "products/show"
    else
      render json: {errors: @product.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    render json: {message: "This product is no longer available."}
  end

end

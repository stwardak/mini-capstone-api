require "test_helper"

class SuppliersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def index
    @suppliers = Supplier.all
    render template: "suppliers/index"
  end

  def show
    @supplier = Supplier.find_by(id: params[:id])
    render template: "suppliers/show"
  end

  def create
    @supplier = Supplier.new(
      name: params[:name],
      price: params[:price],
      image_url: params[:image_url],
      description: params[:description],
    )
    if @supplier.save
      render template: "suppliers/show"
    else
      render json: {errors: @supplier.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    @supplier = Supplier.find_by(id: params[:id])
    @supplier.name = params[:name] || @supplier.name
    @supplier.price = params[:price] || @supplier.price
    @supplier.image_url = params[:image_url] || @supplier.image_url
    @supplier.description = params[:description] || @supplier.description
    if @supplier.save
      render template: "suppliers/show"
    else
      render json: {errors: @supplier.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @supplier = Supplier.find_by(id: params[:id])
    @supplier.destroy
    render json: {message: "This supplier is no longer available."}
  end
end

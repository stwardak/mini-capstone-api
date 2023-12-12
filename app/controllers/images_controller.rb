class ImagesController < ApplicationController
  def index
    @images = Image.all
    render template: "images/index"
  end

  def show
    @image = Image.find_by(id: params[:id])
    render template: "images/show"
  end

  def create
    @image = Image.new(
      url: params[:url],
      product_id: params[:product_id],
    )
    if @image.save
      render template: "images/show"
    else
      render json: {errors: @image.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    @image = Image.find_by(id: params[:id])
    @image.url = params[:url] || @image.url
    @image.product_id = params[:product_id] || @image.product_id
    if @image.save
      render template: "images/show"
    else
      render json: {errors: @image.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @image = Image.find_by(id: params[:id])
    @image.destroy
    render json: {message: "This image is no longer available."}
  end
end

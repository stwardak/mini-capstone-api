class SuppliersController < ApplicationController
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  def index
    @suppliers = Supplier.all
    render :index
  end

end

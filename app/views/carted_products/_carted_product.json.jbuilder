json.extract! carted_product, :id, :created_at, :updated_at
json.url carted_product_url(carted_product, format: :json)
json.id carted_product.id
json.user carted_product.user
json.product carted_product.product
json.order carted_product.order
json.status carted_product.status
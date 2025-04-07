class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show update destroy update_stock]

  # GET /products
  def index
    @pagy, @products = paginate(Product.includes(:category))

    render_success("Data found",{
      **pagy_metadata(@pagy),
      products: @products
    })
  end

  # GET /products/1
  def show
    render_success("Data found", { product: @product.as_json })
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render_success("New product has been created", { product: @product }, :created)
    else
      render_error(@product.errors.full_messages)
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render_success("Product updated successfully", { product: @product })
    else
      render_error(@product.errors.full_messages)
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy!
    render_success("Product deleted successfully", {})
  rescue ActiveRecord::RecordNotDestroyed => e
    render_error(e.record.errors.full_messages)
  end

  # POST /products/update-stock
  def update_stock
    if params[:quantity_sold].nil? || params[:quantity_sold] <= 0
      return render_error("Quantity sold must greater than 0", :bad_request)
    end

    new_stock = @product.stock_quantity - params[:quantity_sold]

    if new_stock < 0
      return render_error("Not enough stock available", :bad_request)
    end

    if @product.update(stock_quantity: new_stock)
      render_success("Product updated successfully", { product: @product })
    else
      render_error(@product.errors.full_messages)
    end
  end

  # GET /products/search?name=?&category_id=?
  def search
    # cek apakah salah satu parameter ada
    if search_params[:name].blank? && search_params[:category_id].blank?
      return render_error("At least one of 'name' or 'category_id' must be provided", :bad_request)
    end

    # cek apakah category valid
    if params[:category_id].present? && !Category.exists?(id: search_params[:category_id])
      return render_error("Invalid category_id: not found", :unprocessable_entity)
    end

    @pagy, @products = paginate(Product
    .search_by_name(search_params[:name])
    .filter_by_category(search_params[:category_id]))


    if @products.exists?
      render_success("Search result found",{
      **pagy_metadata(@pagy),
      products: @products
    })
    else
      render_error("No products match the search criteria", :not_found)
    end
  end

  # GET /inventory/value
  def inventory_value
    total = Product.sum("price * stock_quantity")
    render_success("Get total value of inventory", { total: })
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params.expect(:product_id))
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :price, :stock_quantity, :category_id)
    end

    def search_params
      params.permit(:name, :category_id)
    end
end

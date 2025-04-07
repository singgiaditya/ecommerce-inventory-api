class ProductPromotionsController < ApplicationController
  before_action :set_product_promotion, only: %i[ show update destroy ]

  # GET /product_promotions
  def index
    @pagy, @product_promotions = paginate(ProductPromotion.all)
    render_success("Data found", {
      **pagy_metadata(@pagy),
      product_promotions: @product_promotions
    })
  end

  # GET /product_promotions/1
  def show
    render_success("Data found", { product_promotion: @product_promotion })
  end

  # POST /product_promotions
  def create
    @product_promotion = ProductPromotion.new(product_promotion_params)
    if @product_promotion.save
      render_success("Product promotion created successfully", { product_promotion: @product_promotion }, :created)
    else
      render_error(@product_promotion.errors.full_messages)
    end
  end

  # PATCH/PUT /product_promotions/1
  def update
    if @product_promotion.update(product_promotion_params)
      render_success("Product promotion updated successfully", { product_promotion: @product_promotion })
    else
      render_error(@product_promotion.errors.full_messages)
    end
  end

  # DELETE /product_promotions/1
  def destroy
    @product_promotion.destroy
    render_success("Product promotion deleted successfully", {})
  rescue ActiveRecord::RecordNotDestroyed => e
    render_error(e.record.errors.full_messages)
  end

  private
    def set_product_promotion
      @product_promotion = ProductPromotion.find(params.expect(:id))
    end

    def product_promotion_params
      params.require(:product_promotion).permit(:promotion_id, :product_id)
    end
end

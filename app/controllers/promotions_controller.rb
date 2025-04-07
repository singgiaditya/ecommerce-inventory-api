class PromotionsController < ApplicationController
  before_action :set_promotion, only: %i[ show update destroy ]

  # GET /promotions
  def index
    @pagy, @promotions = paginate(Promotion.all)

    render_success("Data found", {
      **pagy_metadata(@pagy),
      promotions: @promotions
    })
  end

  # GET /promotions/1
  def show
    render_success("Data found", { promotion: @promotion.as_json })
  end

  # POST /promotions
  def create
    @promotion = Promotion.new(promotion_params)

    if @promotion.save
      render_success("New promotion has been created", { promotion: @promotion }, :created)
    else
      render_error(@promotion.errors.full_messages)
    end
  end

  # PATCH/PUT /promotions/1
  def update
    if @promotion.update(promotion_params)
      render_success("Promotion updated successfully", { promotion: @promotion })
    else
      render_error(@promotion.errors.full_messages)
    end
  end

  # DELETE /promotions/1
  def destroy
    @promotion.destroy!
    render_success("Promotion deleted successfully", {})
  rescue ActiveRecord::RecordNotDestroyed => e
    render_error(e.record.errors.full_messages)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promotion
      @promotion = Promotion.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def promotion_params
      params.require(:promotion).permit(:title, :discount_type, :discount_value, :start_date, :end_date)
    end
end

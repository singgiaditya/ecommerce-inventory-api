class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show update destroy ]

  # GET /categories
  def index
    @pagy, @categories = paginate(Category.all)

    render_success("Data found",{
      **pagy_metadata(@pagy),
      categories: @categories
    })

  end

  # GET /categories/1
  def show
    render_success("Data found", { category: @category })
  end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      render_success("New category has been created", { category: @category }, :created)
    else
      render_error(@category.errors.full_message)
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      render_success("Category updated successfully", { category: @category })
    else
      render_error(@category.errors.full_messages)
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy!
    render_success("Category deleted successfully", {})
  rescue ActiveRecord::RecordNotDestroyed => e
    render_error(e.record.errors.full_messages)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end

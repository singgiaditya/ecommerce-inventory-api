# app/controllers/concerns/pagination.rb
module PaginationHelper
  extend ActiveSupport::Concern

  included do
    include Pagy::Backend

    def paginate(collection, items: nil)
      items ||= params[:per_page] || 10
      pagy(collection, items: items)
    end

    def pagy_metadata(pagy)
      {
        current_page: pagy.page,
        total_pages: pagy.pages,
        total_count: pagy.count,
        next_url: pagy.next ? pagy_url_for(pagy.next) : nil,
        prev_url: pagy.prev ? pagy_url_for(pagy.prev) : nil
      }
    end
  end
end

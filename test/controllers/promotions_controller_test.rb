require "test_helper"

class PromotionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @promotion = promotions(:one)
  end

  test "should get index" do
    get promotions_url, as: :json
    assert_response :success
  end

  test "should create promotion" do
    assert_difference("Promotion.count") do
      post promotions_url, params: { promotion: { discount_type: @promotion.discount_type, discount_value: @promotion.discount_value, end_date: @promotion.end_date, start_date: @promotion.start_date, title: @promotion.title } }, as: :json
    end

    assert_response :created
  end

  test "should show promotion" do
    get promotion_url(@promotion), as: :json
    assert_response :success
  end

  test "should update promotion" do
    patch promotion_url(@promotion), params: { promotion: { discount_type: @promotion.discount_type, discount_value: @promotion.discount_value, end_date: @promotion.end_date, start_date: @promotion.start_date, title: @promotion.title } }, as: :json
    assert_response :success
  end

  test "should destroy promotion" do
    assert_difference("Promotion.count", -1) do
      delete promotion_url(@promotion), as: :json
    end

    assert_response :no_content
  end
end

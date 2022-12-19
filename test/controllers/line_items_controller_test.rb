require "test_helper"

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get line_items_url
    assert_response :success
  end

  test "should get new" do
    get new_line_item_url
    assert_response :success
  end

  test "should create line_item has unique product" do
    assert_difference("LineItem.count") do
      post line_items_url, params: { product_id: products(:ruby).id }
    end

    follow_redirect!

    assert_select 'h2', 'Your Pragmatic Cart'
    assert_select 'li span', "1 \u00D7 Programming Ruby 1.9"
  end

  test "should create line_item has duplicate products" do
    assert_difference("LineItem.count") do
      post line_items_url, params: { product_id: products(:product_in_cart).id }
      post line_items_url, params: { product_id: products(:product_in_cart).id }
    end

    follow_redirect!

    assert_select 'h2', 'Your Pragmatic Cart'
    assert_select 'li span', "2 \u00D7 MyLike"
  end

  test "should create line item via turbo-stream" do
    assert_difference "LineItem.count" do
      post line_items_url, params: { product_id: products(:ruby).id },
           as: :turbo_stream
    end
    assert_response :success
    assert_match /<li class="flex justify-between space-x-4 line-item-highlight">/, @response.body
  end

  test "should show line_item" do
    get line_item_url(@line_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_line_item_url(@line_item)
    assert_response :success
  end

  test "should update line_item" do
    patch line_item_url(@line_item), params: { line_item: { product_id: @line_item.product_id } }
    assert_redirected_to line_item_url(@line_item)
  end

  test "should destroy line_item" do
    assert_difference("LineItem.count", -1) do
      delete line_item_url(@line_item)
    end

    assert_redirected_to cart_url(@line_item.cart)
  end
end

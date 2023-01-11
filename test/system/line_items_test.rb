require "application_system_test_case"

class LineItemsTest < ApplicationSystemTestCase
  setup do
    @line_item = line_items(:one)
  end

  test "visiting the index" do
    visit line_items_url
    assert_selector "h1", text: "Line items"
  end

  test "should add line item to cart" do
    visit store_index_url
    click_on "Add to Cart", match: :first

    assert_text "Your Pragmatic Cart"
    assert_text "Programming Ruby 1.0"
  end

  test "should update Line item" do
    visit line_item_url(@line_item)
    click_on "Edit this line item", match: :first

    fill_in "Cart", with: @line_item.cart_id
    fill_in "Product", with: @line_item.product_id
    click_on "Update Line item"

    assert_text "Line item was successfully updated"
    click_on "Back to line items"
  end

  test "should decrement Line item" do
    visit store_index_url
    click_on "Add to Cart", match: :first
    click_on "Add to Cart", match: :first

    click_on "-", match: :first
    assert_text "Your Pragmatic Cart"
    assert_text "1"

    click_on "-", match: :first

    assert_no_text "Your Pragmatic Cart"
  end
end

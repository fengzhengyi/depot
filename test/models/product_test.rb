require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def new_product(image_url)
    Product.new(title: "my book title",
                description: "book notes",
                price: 1,
                image_url: image_url)
  end

  # test "the truth" do
  #   assert true
  # end
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test "product price must be positive" do
    product = Product.new(title: "my book title",
                          description: "book notes",
                          image_url: "aaa.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal [I18n::t('activerecord.errors.models.product.invalid_price')], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal [I18n::t('activerecord.errors.models.product.invalid_price')],
                 product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test "image url" do
    ok = %w{fred.gif fred.jpg fred.jpeg fred.png fred.JPG FRED.Jpg http://a/d/fred.gif}
    bad = %w{fred.doc fred.gif/more fred.gif.more }
    ok.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} must be valid"
    end
    bad.each do |image_url|
      assert new_product(image_url).invalid?, "#{image_url} must be invalid"
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:ruby).title,
                          description: "yyy",
                          price: 1,
                          image_url: "fred.gif")
    assert product.invalid?
    assert_equal [I18n::t('errors.messages.taken')], product.errors[:title]
  end
end

require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["fzktc@163.com"], mail.to
    assert_equal ["512369179@qq.com"], mail.from
    assert_match /1 x Programming Ruby 2.9/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["fzktc@163.com"], mail.to
    assert_equal ["512369179@qq.com"], mail.from
    assert_match /Programming Ruby 2.9/, mail.body.encoded
  end

end

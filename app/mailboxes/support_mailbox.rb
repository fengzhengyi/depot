class SupportMailbox < ApplicationMailbox
  def process
    recent_order = Order.where(email:mail.from.first)
                        .order('created_at desc')
                        .first

    SupportRequest.create!(
      email: mail.from.first,
      subject: mail.subject,
      body: mail.body.to_s,
      order: recent_order
    )
  end
end

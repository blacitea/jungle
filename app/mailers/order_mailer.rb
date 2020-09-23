class OrderMailer < ApplicationMailer
  # METHOD to generate email
  def order_email(order)
    @order = order
    mail(to: @order.email, subject: "Jungle - Thank you for your order! (Order number: #{order.id})").perform_deliveries = false
  end

end

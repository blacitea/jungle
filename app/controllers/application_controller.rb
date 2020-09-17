class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map {|product| { product:product, quantity: cart[product.id.to_s] } }
  end
  helper_method :enhanced_cart

  def cart_subtotal_cents
    enhanced_cart.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
  end
  helper_method :cart_subtotal_cents


  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

    # @enhanced_cart ||= Product.where(id: cart.keys).map {|product| { product:product, quantity: cart[product.id.to_s] } }


  # def enhanced_order
  #   # when select, value of other keys not load, but keys still exist
  #   #@list_of_items = LineItem.where(order_id: @order.id).product
  #   puts "Order id is: #{@order.id}"
  #   puts "LineItem with correct Order ID: #{LineItem.where(order_id: @order.id).inspect}"
  #   puts "We join the tables #{Product.joins(:line_items).inspect}"
  #   @list_of_items = Product.joins(:line_items).merge(LineItem.where(order_id: @order.id))
  #   #   @list_of_items = LineItem.where(order_id: @order.id).select("product_id").map { |item| item.product_id}
  #   puts "list of items "
  #   p @list_of_items
  #   # list = @list_of_items.map do |item|
  #   #   item.product_id
  #   # end
  #   # puts list
  #   # render @list_of_items as :list_of_items pass explicit to review
  #   # @enhanced_order = Product.where(id: @list_of_items)
  #   # puts @enhanced_order.inspect
  #   # @produce_list = @enhanced_order.map {|product| { product:product, quantity: @order[product.id.to_s] } }
  #   # p @produce_list
  # end
  # helper_method :enhanced_order

end

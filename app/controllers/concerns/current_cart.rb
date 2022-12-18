# frozen_string_literal: true

module CurrentCart
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

end

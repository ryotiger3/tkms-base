class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:index, :create]
  before_action :purchase_history

  def index
    if current_user.id != @item.user_id || @item.purchase_history == nil
      @order = Order.new
    else
      redirect_to root_path
    end
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render template: "orders/index"
    end
  end

  private

  def set_product
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(token: params[:token], product_id: params[:product_id], user_id: current_user.id)
  end

  def purchase_history
    if current_user.id == @item.user_id || @item.purchase_history.presence
       redirect_to root_path
    end
  end

  def pay_product 
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
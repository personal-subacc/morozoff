class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :show]

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)

    @order_details = @order.order_details

    if params[:order][:order_status] == "pay_confirm"
      @order_details.update_all(making_status: "make_waiting")
    end

    redirect_to admin_order_path(@order.id)
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end
end
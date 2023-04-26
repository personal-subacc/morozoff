class OrdersController < ApplicationController
  def index
    @orders = current_end_user.orders
  end

  def new
    @order = Order.new
    @cart_items = current_end_user.cart_items
    if @cart_items.empty?
      redirect_to cart_items_path, alert: "カートに商品が入っておりません"
    end
  end

  def confirm
    @cart_items = current_end_user.cart_items
    if @cart_items.empty?
      redirect_to cart_items_path, alert: "カートに商品が入っておりません"
    end

    # @addresses = current_end_user.addresses
    # if @addresses.empty?
    #   redirect_to new_order_path
    # end

    @order = Order.new
    @order.payment_method = params[:order][:payment_method]

    if params[:order][:address_option] == "0"
      @order.address = current_end_user.address
      # Orderモデルのaddressカラム = 現在ログインしているユーザー(EndUserモデル)のaddressカラム
      @order.postal_code = current_end_user.postal_code
      # Orderモデルのpostal_codeカラム = 現在ログインしているユーザー(EndUserモデル)のpostal_codeカラム
      @order.name = current_end_user.last_name + current_end_user.first_name
      # Orderモデルのnameカラム = 現在ログインしているユーザー(EndUserモデル)のlast_nameカラムとfirst_nameカラム
    elsif params[:order][:address_option] == "1"
      # if @address = Address.find(params[:order][:address_id])
      # if @address = Address.find_by(id: params[:order][:address_id])
      if @address = Address.find_by(id: params[:address][:id])
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name
      else
        render :new
      end

    elsif params[:order][:address_option] == "2"
			@order.postal_code = params[:order][:postal_code]
			@order.address = params[:order][:address]
			@order.name = params[:order][:name]
    end
  end

  def complete
    @cart_items = current_end_user.cart_items
    # if @cart_items.empty?
    #   redirect_to cart_items_path, alert: "カートに商品が入っておりません"
    # end
  end

  def create
    @order = Order.new(order_params)
    @order.end_user_id = current_end_user.id
    @order.shipping_cost = 800
    @order.billing_amount = 0
    # @order関連は82,83行目に追記(eachメソッドが絡むため)
    @order.save
    # 83行目の @order.save だけだと請求合計金額(billing_amount)が合わなくなる

    @cart_items = current_end_user.cart_items
    @cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      # order_detailという(中間テーブルOrderDetailモデルの)空の箱を作成し、そこに情報を移す作業、紐付け
      order_detail.item_id = cart_item.item.id
      order_detail.amount = cart_item.amount
      order_detail.price = cart_item.item.non_taxed_price * 1.1

      order_detail.order_id = @order.id
      order_detail.save

      @order.billing_amount += (cart_item.item.non_taxed_price * 1.1).round * cart_item.amount
      # @order.billing_amount = @order.billing_amount + @order.shipping_cost
      @order.save
    end

    @cart_items.destroy_all
    redirect_to complete_orders_path
  end

  # def create
  #   @order = Order.new(session[:order])
  #   @order.end_user_id = current_end_user.id
  #   @order.save

  #   @cart_item = CartItem.where(end_user_id: current_end_user.id)

  #   @cart_item.each do |order_item|
  #     @order_item = OrderItem.new({
  #       order_id: @order.id,
  #       item_id: order_item.item_id,
  #       amount: order_item.amount,
  #       price: order_item.item.non_taxed_price
  #     })
  #     @order_item.save
  #   end

  #   @cart_items.destroy_all
  #   redirect_to complete_orders_path
  # end

  private
  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :shipping_cost, :billing_amount, :payment_method, :order_status)
  end
end
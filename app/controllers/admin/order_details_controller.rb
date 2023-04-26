class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)

    @order = @order_detail.order

    if params[:order_detail][:making_status] == "making"
      # 注文商品の製作ステータスが1つでも"製作中"になったら、注文ステータスを"製作中"に更新
      @order.update(order_status: "on_making")
    end

    count = 0
    @order_details = @order.order_details

    @order_details.each do |order_detail|
      if order_detail.making_status == "completed"
        count += 1
      end
    end

    if @order_details.count == count
      # 個数を数えるcountメソッドを利用。右辺のcountは14、19行目に記述あり(ステータスがcompletedになった注文商品の数)
      # 注文商品全ての製作ステータスが"製作完了"になったら、注文ステータスを"発送準備中"に更新
      @order.update(order_status: "ship_preparing")
    end

    redirect_to admin_order_path(@order.id)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
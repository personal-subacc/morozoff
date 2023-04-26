class CartItemsController < ApplicationController
  def index
    # @cart_items = CartItem.all
    @cart_items = current_end_user.cart_items
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_end_user.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    if current_end_user.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
    #例 if CartItem.find_by(CartItemモデルのitem_idが1番の"イチゴケーキ": 商品詳細でポチったのが、CartItemモデルのitem_idが1番の"イチゴケーキ").既に存在していたら
      cart_item = current_end_user.cart_items.find_by(item_id: params[:cart_item][:item_id])
      new_amount = cart_item.amount + params[:cart_item][:amount].to_i
    # find_byで特定してきた商品の、既にカート内にある数　+　新たにポチった数(CartItemモデルのamountカラム)
    # to_iメソッドで文字列型から整数型に変換　ないとTypeError吐く
      cart_item.update(amount: new_amount)
    else
      cart_item = CartItem.new(cart_item_params)
      cart_item.save
    end
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:end_user_id, :item_id, :amount)
  end
end
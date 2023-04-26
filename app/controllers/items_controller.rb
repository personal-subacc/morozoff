class ItemsController < ApplicationController
  def index
    if params[:search_key].present?  # ジャンル検索したかどうか(search_keyがあるかどうか)
      @items = Item.where(genre_id: params[:search_key])  # Itemモデルのgenre_idカラムが、search_keyキーとマッチするレコードだけを抽出
    else
      @items = Item.all
    end
  end

  # 与えられた条件にマッチするレコードをすべて返す whereメソッドを利用
  # 与えられた条件にマッチするレコードのうち最初のレコードだけを返す find_byメソッドは不適切

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :show, :new, :edit]

  def index
    @items = Item.search(params[:search])
    # .searchメソッドは自作のメソッド。このままだと NoMethodError 吐く。モデル(item.rb)に記述。
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = '商品を新規登録しました'
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to '/admin/items'
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :item_name, :description, :image, :non_taxed_price, :sale_status)
  end
end
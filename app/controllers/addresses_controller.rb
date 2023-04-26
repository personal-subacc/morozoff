class AddressesController < ApplicationController
  def index
    # @addresses = Address.all
    @addresses = current_end_user.addresses
    # Addressモデルからallメソッドで全てのデータを取り出す仕様にすると、他人の配送先住所も表示されてしまう
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.end_user_id = current_end_user.id
    if @address.save
      flash[:notice] = "配送先を登録しました"
      redirect_to addresses_path
    else
      @addresses = current_end_user.addresses
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "配送先を更新しました"
      redirect_to addresses_path
    else
      render :edit
    end
  end

  private
  def address_params
    params.require(:address).permit(:end_user_id, :name, :postal_code, :address)
  end
end
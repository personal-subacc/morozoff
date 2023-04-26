class EndUsersController < ApplicationController
  before_action :authenticate_end_user!

  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      flash[:notice] = '編集されました'
      redirect_to end_user_path(@end_user.id)
    else
      render :edit
    end
  end

  def quit_confirm
  end

  def hide
    @end_user = EndUser.find(params[:end_user_id])
    @end_user.update(is_deleted: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private
  def end_user_params
    params.require(:end_user).permit(
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :postal_code,
      :address,
      :phone_number,
      :email
    )
  end
end
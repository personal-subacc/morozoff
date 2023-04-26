# frozen_string_literal: true

class EndUsers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  before_action :reject_user, only:[:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  protected

  def reject_user
    #モデル名.find_by(カラム名: 検索する値)
    @end_user = EndUser.find_by(email: params[:end_user][:email].downcase)  #find_byメソッドを使ってデータが存在しているかどうかを見る
    if @end_user
      
      if (@end_user.valid_password?(params[:end_user][:password]) && (@end_user.active_for_authentication? == false))
        #（前半）"入力されたパスワード"と'データベースに保存されているパスワード'が合っているか
        #（後半）EndUserモデルに定義したメソッドで、それがfalseであれば退会していることになる

        flash[:withdrawal] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_end_user_session_path
      end
      
    else
      
      flash[:error] = "必須項目を入力してください"
      
    end
    
  end

end

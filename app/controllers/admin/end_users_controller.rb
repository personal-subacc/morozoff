class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!, only: [:index]

  def index
    @end_users = EndUser.all
  end
end
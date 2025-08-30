class ProfilesController < ApplicationController
  # ログインしていないとアクセスできないようにする
  before_action :authenticate_user!
  
  def show
    @profile = current_user.profile
  end
  
  def edit
  end
end
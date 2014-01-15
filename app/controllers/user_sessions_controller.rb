#encoding: utf-8
class UserSessionsController < ApplicationController

  before_filter :require_user, :only => :destroy

  def new
    if current_user.nil?
      @user_session = UserSession.new
    else
      flash[:warning] = 'Ya inició sesión!'
      redirect_back_or_default branches_url
    end

  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:success] = 'Inició sesión correctamente!'
      redirect_back_or_default branches_url
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:success] = 'Cerró sesión correctamente!'
    redirect_back_or_default root_url
  end
end

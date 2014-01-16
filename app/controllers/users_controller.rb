class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :require_user, :only => [:show, :edit, :update, :index, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    @user.add_role user_params[:role] if user_params[:role]

    # TODO: refactorizar esta parte de código
    if user_params[:role] == 'admin_company' && !user_params.include?(:company_id)
      @user.errors[:base] = 'No se pudo crear el usuario por falta de parametros'
    elsif user_params[:role] == 'admin_company'
      @company = Company.find(params[:company_id])
    end

    respond_to do |format|
      if @user.save
        @company.update_attribute('admin_id', @user.id) unless @company.nil?
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
        format.js
      else
        # TODO: verificar que se agregue el error cuando se envía el rol admin_branches y no tiene parámetro company_id
        puts @user.errors.inspect
        sleep 2
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :address, :phone, :login, :email, :password, :password_confirmation)
    end
end

class BranchesController < ApplicationController
  before_action :set_branch, only: [:show, :edit, :update, :destroy]

  # GET /branches
  # GET /branches.json
  def index
    @branches = Branch.order(:id) if current_user.is_admin?
    @branches = current_user.company.branches.order(:id) if current_user.is_admin_company?
    if @branches.nil?
      redirect_back_or_default home_url
    end
  end

  # GET /branches/1
  # GET /branches/1.json
  def show
    if @branch.admin.nil?
      @user = User.new
    end
  end

  # GET /branches/new
  def new
    @branch = Branch.new
    params[:company_id] = current_user.company.id if current_user.is_admin_company?

    respond_to do |format|
      format.html
      format.widget { render '_form_js.html.erb', layout: false }
    end
  end

  # GET /branches/1/edit
  def edit

    respond_to do |format|
      format.html
      format.widget { render '_form_js.html.erb', layout: false }
    end
  end

  # POST /branches
  # POST /branches.json
  def create
    @branch = Branch.new(branch_params)

    respond_to do |format|
      if @branch.save
        format.html { redirect_to @branch, success: 'Branch was successfully created.' }
        format.json { render action: 'show', status: :created, location: @branch }
        format.js { render partial: 'shared/create_record_js', locals: { object: @branch } }
      else
        format.html { render action: 'new' }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
        format.js { render :js => 'show_record_errors(' + @branch.errors.full_messages.to_json + ');' }
      end
    end
  end

  # PATCH/PUT /branches/1
  # PATCH/PUT /branches/1.json
  def update
    respond_to do |format|
      if @branch.update(branch_params)
        format.html { redirect_to @branch, success: 'Branch was successfully updated.' }
        format.json { head :no_content }
        format.js { render partial: 'shared/create_record_js', locals: { object: @branch } }
      else
        format.html { render action: 'edit' }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
        format.js { render :js => 'show_record_errors(' + @branch.errors.full_messages.to_json + ');' }
      end
    end
  end

  # DELETE /branches/1
  # DELETE /branches/1.json
  def destroy
    @branch.destroy
    respond_to do |format|
      format.html { redirect_to branches_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch
      @branch = Branch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def branch_params
      params.require(:branch).permit(:name, :company_id, :address, :phone)
    end
end

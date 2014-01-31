class PromotionsController < ApplicationController
  before_action :set_promotion, only: [:show, :edit, :update, :destroy]

  # GET /promotions
  # GET /promotions.json
  def index
    @promotions = Promotion.all
  end

  # GET /promotions/1
  # GET /promotions/1.json
  def show
  end

  # GET /promotions/new
  def new
    @promotion = Promotion.new
    params[:company_id] = current_user.company.id if current_user.is_admin_company?

    respond_to do |format|
      format.html
      format.widget { render '_form_js.html.erb', layout: false }
    end
  end

  # GET /promotions/1/edit
  def edit

    respond_to do |format|
      format.html
      format.widget { render '_form_js.html.erb', layout: false }
    end
  end

  # POST /promotions
  # POST /promotions.json
  def create
    @promotion = Promotion.new(promotion_params)

    respond_to do |format|
      if @promotion.save
        format.html { redirect_to @promotion, notice: 'Promotion was successfully created.' }
        format.json { render action: 'show', status: :created, location: @promotion }
        format.js { render partial: 'shared/create_record_js', locals: { object: @promotion } }
      else
        format.html { render action: 'new' }
        format.json { render json: @promotion.errors, status: :unprocessable_entity }
        format.js { render :js => 'show_record_errors(' + @promotion.errors.full_messages.to_json + ');' }
      end
    end
  end

  # PATCH/PUT /promotions/1
  # PATCH/PUT /promotions/1.json
  def update
    respond_to do |format|
      if @promotion.update(promotion_params)
        format.html { redirect_to @promotion, notice: 'Promotion was successfully updated.' }
        format.json { head :no_content }
        format.js { render partial: 'shared/create_record_js', locals: { object: @promotion } }
      else
        format.html { render action: 'edit' }
        format.json { render json: @promotion.errors, status: :unprocessable_entity }
        format.js { render :js => 'show_record_errors(' + @promotion.errors.full_messages.to_json + ');' }
      end
    end
  end

  # DELETE /promotions/1
  # DELETE /promotions/1.json
  def destroy
    @promotion.destroy
    respond_to do |format|
      format.html { redirect_to promotions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promotion
      @promotion = Promotion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def promotion_params
      params.require(:promotion).permit(:description, :company_id)
    end
end

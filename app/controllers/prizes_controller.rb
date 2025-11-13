class PrizesController < ApplicationController
  include MyUtility
  before_action :set_prize, only: [:show, :edit, :update, :destroy]

  # GET /prizes
  def index
    placeholder_set
    param_set

    @count	= Prize.notnil().includes(:pc_name).ransack(params[:q]).result.hit_count()
    @search	= Prize.notnil().includes(:pc_name).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @prizes	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "prize", params_name: "prize_form", type: "number")
  end
  # GET /prizes/1
  #def show
  #end

  # GET /prizes/new
  #def new
  #  @prize = Prize.new
  #end

  # GET /prizes/1/edit
  #def edit
  #end

  # POST /prizes
  #def create
  #  @prize = Prize.new(prize_params)

  #  if @prize.save
  #    redirect_to @prize, notice: "Prize was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /prizes/1
  #def update
  #  if @prize.update(prize_params)
  #    redirect_to @prize, notice: "Prize was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /prizes/1
  #def destroy
  #  @prize.destroy
  #  redirect_to prizes_url, notice: "Prize was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prize
      @prize = Prize.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def prize_params
      params.require(:prize).permit(:result_no, :generate_no, :e_no, :prize)
    end
end

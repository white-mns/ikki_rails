class PkResultsController < ApplicationController
  include MyUtility
  before_action :set_pk_result, only: [:show, :edit, :update, :destroy]

  # GET /pk_results
  def index
    placeholder_set
    param_set

    @count	= PkResult.notnil().includes(:pc_name).ransack(params[:q]).result.hit_count()
    @search	= PkResult.notnil().includes(:pc_name).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @pk_results	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "battle_result", params_name: "battle_result_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_result_eq_any",
                             checkboxes: [{params_name: "result_win",   value: 1, first_checked: true},
                                          {params_name: "result_draw",  value: 0, first_checked: true},
                                          {params_name: "result_lose" , value: -1, first_checked: true}])

  end
  # GET /pk_results/1
  #def show
  #end

  # GET /pk_results/new
  #def new
  #  @pk_result = PkResult.new
  #end

  # GET /pk_results/1/edit
  #def edit
  #end

  # POST /pk_results
  #def create
  #  @pk_result = PkResult.new(pk_result_params)

  #  if @pk_result.save
  #    redirect_to @pk_result, notice: "Pk result was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /pk_results/1
  #def update
  #  if @pk_result.update(pk_result_params)
  #    redirect_to @pk_result, notice: "Pk result was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /pk_results/1
  #def destroy
  #  @pk_result.destroy
  #  redirect_to pk_results_url, notice: "Pk result was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pk_result
      @pk_result = PkResult.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pk_result_params
      params.require(:pk_result).permit(:result_no, :generate_no, :e_no, :battle_result)
    end
end

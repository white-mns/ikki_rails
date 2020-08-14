class StatusesController < ApplicationController
  include MyUtility
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  # GET /statuses
  def index
    placeholder_set
    param_set

    @count	= Status.notnil().includes(:pc_name, :guardian).search(params[:q]).result.hit_count()
    @search	= Status.notnil().includes(:pc_name, :guardian).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @statuses	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "clv", params_name: "clv_form", type: "number")
    params_to_form(params, @form_params, column_name: "ikki", params_name: "ikki_form", type: "number")
    params_to_form(params, @form_params, column_name: "guardian_id", params_name: "guardian_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "cp", params_name: "cp_form", type: "number")
    params_to_form(params, @form_params, column_name: "ps", params_name: "ps_form", type: "number")
    params_to_form(params, @form_params, column_name: "mhp", params_name: "mhp_form", type: "number")
    params_to_form(params, @form_params, column_name: "msp", params_name: "msp_form", type: "number")
    params_to_form(params, @form_params, column_name: "psp", params_name: "psp_form", type: "number")
    params_to_form(params, @form_params, column_name: "str", params_name: "str_form", type: "number")
    params_to_form(params, @form_params, column_name: "vit", params_name: "vit_form", type: "number")
    params_to_form(params, @form_params, column_name: "tec", params_name: "tec_form", type: "number")
    params_to_form(params, @form_params, column_name: "int", params_name: "int_form", type: "number")
    params_to_form(params, @form_params, column_name: "mnd", params_name: "mnd_form", type: "number")
    params_to_form(params, @form_params, column_name: "agi", params_name: "agi_form", type: "number")

    params_to_form(params, @form_params, column_name: "guardian_name", params_name: "guardian_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "guardian_name_cont_any",
                             checkboxes: [{params_name: "guardian_hot", value: "熱血", first_checked: false},
                                          {params_name: "guardian_goddes" , value: "女神", first_checked: false},
                                          {params_name: "guardian_lucky" , value: "幸星", first_checked: false},
                                          {params_name: "guardian_hermit" , value: "隠者", first_checked: false},
                                          {params_name: "guardian_hero" , value: "英雄", first_checked: false},
                                          {params_name: "guardian_satan" , value: "魔王", first_checked: false},
                                          {params_name: "guardian_saint" , value: "聖人", first_checked: false}])
  end
  # GET /statuses/1
  #def show
  #end

  # GET /statuses/new
  #def new
  #  @status = Status.new
  #end

  # GET /statuses/1/edit
  #def edit
  #end

  # POST /statuses
  #def create
  #  @status = Status.new(status_params)

  #  if @status.save
  #    redirect_to @status, notice: "Status was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /statuses/1
  #def update
  #  if @status.update(status_params)
  #    redirect_to @status, notice: "Status was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /statuses/1
  #def destroy
  #  @status.destroy
  #  redirect_to statuses_url, notice: "Status was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def status_params
      params.require(:status).permit(:result_no, :generate_no, :e_no, :clv, :ikki, :guardian_id, :cp, :ps, :mhp, :msp, :psp, :str, :vit, :tec, :int, :mnd, :agi)
    end
end

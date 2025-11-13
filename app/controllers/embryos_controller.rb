class EmbryosController < ApplicationController
  include MyUtility
  before_action :set_embryo, only: [:show, :edit, :update, :destroy]

  # GET /embryos
  def index
    placeholder_set
    param_set

    @count	= Embryo.notnil().includes(:pc_name, :embryo).ransack(params[:q]).result.hit_count()
    @search	= Embryo.notnil().includes(:pc_name, :embryo).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @embryos	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "order", params_name: "order_form", type: "number")
    params_to_form(params, @form_params, column_name: "embryo_id", params_name: "embryo_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "is_physics", params_name: "is_physics_form", type: "number")
    params_to_form(params, @form_params, column_name: "lv", params_name: "lv_form", type: "number")

    params_to_form(params, @form_params, column_name: "embryo_name", params_name: "embryo_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_name", params_name: "skill_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "is_physics_eq_any",
                             checkboxes: [{params_name: "embryo_physics", value: 1, first_checked: false},
                                          {params_name: "embryo_magic" , value: 0, first_checked: false}])
  end
  # GET /embryos/1
  #def show
  #end

  # GET /embryos/new
  #def new
  #  @embryo = Embryo.new
  #end

  # GET /embryos/1/edit
  #def edit
  #end

  # POST /embryos
  #def create
  #  @embryo = Embryo.new(embryo_params)

  #  if @embryo.save
  #    redirect_to @embryo, notice: "Embryo was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /embryos/1
  #def update
  #  if @embryo.update(embryo_params)
  #    redirect_to @embryo, notice: "Embryo was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /embryos/1
  #def destroy
  #  @embryo.destroy
  #  redirect_to embryos_url, notice: "Embryo was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_embryo
      @embryo = Embryo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def embryo_params
      params.require(:embryo).permit(:result_no, :generate_no, :e_no, :order, :embryo_id, :is_physics, :lv)
    end
end

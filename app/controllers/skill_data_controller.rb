class SkillDataController < ApplicationController
  include MyUtility
  before_action :set_skill_datum, only: [:show, :edit, :update, :destroy]

  # GET /skill_data
  def index
    placeholder_set
    param_set

    @count	= SkillDatum.includes(:embryo, :gift).wheres(params).groups(params).ransack(params[:q]).result.hit_count()
    @search	= SkillDatum.includes(:embryo, :gift).wheres(params).groups(params).page(params[:page]).ransack(params[:q])
    @search.sorts = ["embryo_id asc", "is_physics desc", "lv asc"] if @search.sorts.empty?
    @skill_data	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "skill_id", params_name: "skill_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "embryo_id", params_name: "embryo_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "is_physics", params_name: "is_physics_form", type: "number")
    params_to_form(params, @form_params, column_name: "lv", params_name: "lv_form", type: "number")
    params_to_form(params, @form_params, column_name: "sp", params_name: "sp_form", type: "number")
    params_to_form(params, @form_params, column_name: "gift_id", params_name: "gift_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "gp", params_name: "gp_form", type: "number")

    params_to_form(params, @form_params, column_name: "embryo_name", params_name: "embryo_form", type: "text")
    params_to_form(params, @form_params, column_name: "gift_name", params_name: "gift_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "is_physics_eq_any",
                             checkboxes: [{params_name: "embryo_physics", value: 1, first_checked: false},
                                          {params_name: "embryo_magic" , value: 0, first_checked: false}])

    toggle_params_to_variable(params, @form_params, params_name: "show_skill", first_opened: true)
    @form_params["base_first"]    = (!params["is_form"]) ? "1" : "0"
  end
  # GET /skill_data/1
  #def show
  #end

  # GET /skill_data/new
  #def new
  #  @skill_datum = SkillDatum.new
  #end

  # GET /skill_data/1/edit
  #def edit
  #end

  # POST /skill_data
  #def create
  #  @skill_datum = SkillDatum.new(skill_datum_params)

  #  if @skill_datum.save
  #    redirect_to @skill_datum, notice: "Skill datum was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /skill_data/1
  #def update
  #  if @skill_datum.update(skill_datum_params)
  #    redirect_to @skill_datum, notice: "Skill datum was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /skill_data/1
  #def destroy
  #  @skill_datum.destroy
  #  redirect_to skill_data_url, notice: "Skill datum was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill_datum
      @skill_datum = SkillDatum.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def skill_datum_params
      params.require(:skill_datum).permit(:skill_id, :name, :embryo_id, :is_physics, :lv, :sp, :gift_id, :gp)
    end
end

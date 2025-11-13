class SkillsController < ApplicationController
  include MyUtility
  before_action :set_skill, only: [:show, :edit, :update, :destroy]

  # GET /skills
  def index
    placeholder_set
    param_set

    @count	= Skill.notnil().includes(:pc_name, :skill, embryo: :embryo).wheres(params).groups(params).ransack(params[:q]).result.hit_count()
    @search	= Skill.notnil().includes(:pc_name, :skill, embryo: :embryo).wheres(params).groups(params).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @skills	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    params[:q]["embryo_embryo_id_not_eq"] = 0

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "order", params_name: "order_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_id", params_name: "skill_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "gift_open", params_name: "gift_open_form", type: "number")

    params_to_form(params, @form_params, column_name: "skill_name", params_name: "skill_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_lv", params_name: "lv_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_sp", params_name: "sp_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_gp", params_name: "gp_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_gift_name", params_name: "gift_form", type: "text")
    params_to_form(params, @form_params, column_name: "embryo_embryo_name", params_name: "embryo_form", type: "text")
    params_to_form(params, @form_params, column_name: "embryo_lv", params_name: "embryo_lv_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "skill_is_physics_eq_any",
                             checkboxes: [{params_name: "embryo_physics", value: 1, first_checked: false},
                                          {params_name: "embryo_magic" , value: 0, first_checked: false}])
    checkbox_params_set_query_any(params, @form_params, query_name: "gift_open_eq_any",
                             checkboxes: [{params_name: "gift_open", value: 1, first_checked: false},
                                          {params_name: "gift_none" , value: 0, first_checked: false}])

    toggle_params_to_variable(params, @form_params, params_name: "show_skill", first_opened: true)
    @form_params["base_first"]    = (!params["is_form"]) ? "1" : "0"
  end
  # GET /skills/1
  #def show
  #end

  # GET /skills/new
  #def new
  #  @skill = Skill.new
  #end

  # GET /skills/1/edit
  #def edit
  #end

  # POST /skills
  #def create
  #  @skill = Skill.new(skill_params)

  #  if @skill.save
  #    redirect_to @skill, notice: "Skill was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /skills/1
  #def update
  #  if @skill.update(skill_params)
  #    redirect_to @skill, notice: "Skill was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /skills/1
  #def destroy
  #  @skill.destroy
  #  redirect_to skills_url, notice: "Skill was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def skill_params
      params.require(:skill).permit(:result_no, :generate_no, :e_no, :order, :skill_id, :gift_open)
    end
end

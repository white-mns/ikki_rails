class NewSkillsController < ApplicationController
  include MyUtility
  before_action :set_new_skill, only: [:show, :edit, :update, :destroy]

  # GET /new_skills
  def index
    placeholder_set
    param_set

    @count	= NewSkill.notnil().includes(skill: :embryo).search(params[:q]).result.hit_count()
    @search	= NewSkill.notnil().includes(skill: :embryo).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @new_skills	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("~%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_id", params_name: "skill_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "skill_name", params_name: "skill_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_embryo_name", params_name: "embryo_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_lv", params_name: "lv_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_sp", params_name: "sp_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_gp", params_name: "gp_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_gift_name", params_name: "gift_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "skill_is_physics_eq_any",
                             checkboxes: [{params_name: "embryo_physics", value: 1, first_checked: false},
                                          {params_name: "embryo_magic" , value: 0, first_checked: false}])

    toggle_params_to_variable(params, @form_params, params_name: "show_embryo")
    toggle_params_to_variable(params, @form_params, params_name: "show_skill")
  end
  # GET /new_skills/1
  #def show
  #end

  # GET /new_skills/new
  #def new
  #  @new_skill = NewSkill.new
  #end

  # GET /new_skills/1/edit
  #def edit
  #end

  # POST /new_skills
  #def create
  #  @new_skill = NewSkill.new(new_skill_params)

  #  if @new_skill.save
  #    redirect_to @new_skill, notice: "New skill was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /new_skills/1
  #def update
  #  if @new_skill.update(new_skill_params)
  #    redirect_to @new_skill, notice: "New skill was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /new_skills/1
  #def destroy
  #  @new_skill.destroy
  #  redirect_to new_skills_url, notice: "New skill was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_skill
      @new_skill = NewSkill.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def new_skill_params
      params.require(:new_skill).permit(:result_no, :generate_no, :skill_id)
    end
end

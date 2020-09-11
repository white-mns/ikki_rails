class NewDefeatEnemiesController < ApplicationController
  include MyUtility
  before_action :set_new_defeat_enemy, only: [:show, :edit, :update, :destroy]

  # GET /new_defeat_enemies
  def index
    placeholder_set
    param_set

    @count	= NewDefeatEnemy.notnil().includes(:enemy, [party_info: [party_members: :pc_name]], [battle_info: [:current_area, :enemy_party_name]]).search(params[:q]).result.hit_count()
    @search	= NewDefeatEnemy.notnil().includes(:enemy, [party_info: [party_members: :pc_name]], [battle_info: [:current_area, :enemy_party_name]]).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @new_defeat_enemies	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("1~%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "enemy_id", params_name: "enemy_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "member_num", params_name: "member_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "is_boss", params_name: "is_boss_form", type: "number")
    params_to_form(params, @form_params, column_name: "area_id", params_name: "area_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "advance", params_name: "advance_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_no", params_name: "party_no_form", type: "number")

    params_to_form(params, @form_params, column_name: "enemy_name", params_name: "enemy_form", type: "number")

    params_to_form(params, @form_params, column_name: "party_info_party_members_e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_info_party_members_pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "party_info_name", params_name: "party_name_form", type: "text")

    params_to_form(params, @form_params, column_name: "battle_info_current_area_advance", params_name: "advance_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_info_current_area_bellicosity", params_name: "bellicosity_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_info_current_area_area_name", params_name: "name_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "member_num_eq_any",
                             checkboxes: [{params_name: "member_num_0", value: 0, first_checked: true},
                                          {params_name: "member_num_1", value: 1, first_checked: false},
                                          {params_name: "member_num_2", value: 2, first_checked: false},
                                          {params_name: "member_num_3", value: 3, first_checked: false},
                                          {params_name: "member_num_4", value: 4, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "is_boss_eq_any",
                             checkboxes: [{params_name: "is_encounter", value: 0, first_checked: false},
                                          {params_name: "is_boss" ,     value: 1, first_checked: true}])
     
    checkbox_params_set_query_any(params, @form_params, query_name: "battle_info_current_area_area_level_eq_any",
                             checkboxes: [{params_name: "level_1", value: 1, first_checked: false},
                                          {params_name: "level_2", value: 2, first_checked: false},
                                          {params_name: "level_3", value: 3, first_checked: false},
                                          {params_name: "level_4", value: 4, first_checked: false},
                                          {params_name: "level_5", value: 5, first_checked: false},
                                          {params_name: "level_6", value: 6, first_checked: false}])
  end
  # GET /new_defeat_enemies/1
  #def show
  #end

  # GET /new_defeat_enemies/new
  #def new
  #  @new_defeat_enemy = NewDefeatEnemy.new
  #end

  # GET /new_defeat_enemies/1/edit
  #def edit
  #end

  # POST /new_defeat_enemies
  #def create
  #  @new_defeat_enemy = NewDefeatEnemy.new(new_defeat_enemy_params)

  #  if @new_defeat_enemy.save
  #    redirect_to @new_defeat_enemy, notice: "New defeat enemy was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /new_defeat_enemies/1
  #def update
  #  if @new_defeat_enemy.update(new_defeat_enemy_params)
  #    redirect_to @new_defeat_enemy, notice: "New defeat enemy was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /new_defeat_enemies/1
  #def destroy
  #  @new_defeat_enemy.destroy
  #  redirect_to new_defeat_enemies_url, notice: "New defeat enemy was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_defeat_enemy
      @new_defeat_enemy = NewDefeatEnemy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def new_defeat_enemy_params
      params.require(:new_defeat_enemy).permit(:result_no, :generate_no, :enemy_id, :member_num, :is_boss, :area_id, :advance, :party_no)
    end
end

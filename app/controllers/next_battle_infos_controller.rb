class NextBattleInfosController < ApplicationController
  include MyUtility
  before_action :set_next_battle_info, only: [:show, :edit, :update, :destroy]

  # GET /next_battle_infos
  def index
    placeholder_set
    param_set

    @count	= NextBattleInfo.notnil().includes([current_area: :area], [party_info: [party_members: :pc_name]], [enemy_members: :enemy]).search(params[:q]).result.hit_count()
    @search	= NextBattleInfo.notnil().includes([current_area: :area], [party_info: [party_members: :pc_name]], [enemy_members: :enemy]).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @next_battle_infos	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "party_no", params_name: "party_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "is_boss", params_name: "is_boss_form", type: "number")
    params_to_form(params, @form_params, column_name: "enemy_party_name_id", params_name: "enemy_party_name_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "enemy_names", params_name: "enemy_names_form", type: "text")

    params_to_form(params, @form_params, column_name: "party_info_member_num", params_name: "member_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "member_num", params_name: "enemy_member_num_form", type: "number")

    params_to_form(params, @form_params, column_name: "party_info_party_members_e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_info_party_members_pc_name_name", params_name: "pc_name_form", type: "text")

    params_to_form(params, @form_params, column_name: "enemy_party_name_name", params_name: "enemy_party_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "party_info_name", params_name: "party_name_form", type: "text")

    params_to_form(params, @form_params, column_name: "current_area_advance", params_name: "advance_form", type: "number")
    params_to_form(params, @form_params, column_name: "current_area_bellicosity", params_name: "bellicosity_form", type: "number")
    params_to_form(params, @form_params, column_name: "current_area_area_name", params_name: "name_form", type: "text")
 
    checkbox_params_set_query_any(params, @form_params, query_name: "party_info_member_num_eq_any",
                             checkboxes: [{params_name: "member_num_1", value: 1, first_checked: false},
                                          {params_name: "member_num_2", value: 2, first_checked: false},
                                          {params_name: "member_num_3", value: 3, first_checked: false},
                                          {params_name: "member_num_4", value: 4, first_checked: false}])
    checkbox_params_set_query_single(params, @form_params, checkbox: {params_name: "member_num_5", value: 5, query_name: "party_info_member_num_gteq_any", first_checked: false})
    
    checkbox_params_set_query_any(params, @form_params, query_name: "current_area_area_level_eq_any",
                             checkboxes: [{params_name: "level_1", value: 1, first_checked: false},
                                          {params_name: "level_2", value: 2, first_checked: false},
                                          {params_name: "level_3", value: 3, first_checked: false},
                                          {params_name: "level_4", value: 4, first_checked: false},
                                          {params_name: "level_5", value: 5, first_checked: false},
                                          {params_name: "level_6", value: 6, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "is_boss_eq_any",
                             checkboxes: [{params_name: "is_encounter", value: 0, first_checked: false},
                                          {params_name: "is_boss" ,     value: 1, first_checked: false}])

    toggle_params_to_variable(params, @form_params, params_name: "show_member_num")
    toggle_params_to_variable(params, @form_params, params_name: "show_party_name")
    toggle_params_to_variable(params, @form_params, params_name: "show_current_area", first_opened: true)
    @form_params["base_first"]    = (!params["is_form"]) ? "1" : "0"
  end
  # GET /next_battle_infos/1
  #def show
  #end

  # GET /next_battle_infos/new
  #def new
  #  @next_battle_info = NextBattleInfo.new
  #end

  # GET /next_battle_infos/1/edit
  #def edit
  #end

  # POST /next_battle_infos
  #def create
  #  @next_battle_info = NextBattleInfo.new(next_battle_info_params)

  #  if @next_battle_info.save
  #    redirect_to @next_battle_info, notice: "Next battle info was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /next_battle_infos/1
  #def update
  #  if @next_battle_info.update(next_battle_info_params)
  #    redirect_to @next_battle_info, notice: "Next battle info was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /next_battle_infos/1
  #def destroy
  #  @next_battle_info.destroy
  #  redirect_to next_battle_infos_url, notice: "Next battle info was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_next_battle_info
      @next_battle_info = NextBattleInfo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def next_battle_info_params
      params.require(:next_battle_info).permit(:result_no, :generate_no, :party_no, :is_boss, :enemy_party_name_id, :member_num, :enemy_names)
    end
end

class BattleResultsController < ApplicationController
  include MyUtility
  before_action :set_battle_result, only: [:show, :edit, :update, :destroy]

  # GET /battle_results
  def index
    placeholder_set
    param_set

    @count	= BattleResult.notnil().includes([battle_info: [:current_area, :enemy_party_name]], [party_info: [party_members: :pc_name]], [enemy_members: :enemy]).search(params[:q]).result.hit_count()
    @search	= BattleResult.notnil().includes([battle_info: [:current_area, :enemy_party_name]], [party_info: [party_members: :pc_name]], [enemy_members: :enemy]).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @battle_results	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "before_result_no", params_name: "before_result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "before_generate_no", params_name: "before_generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_no", params_name: "party_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_result", params_name: "battle_result_form", type: "number")

    params_to_form(params, @form_params, column_name: "battle_info_enemy_names", params_name: "enemy_names_form", type: "text")

    params_to_form(params, @form_params, column_name: "party_info_member_num", params_name: "member_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_info_member_num", params_name: "enemy_member_num_form", type: "number")

    params_to_form(params, @form_params, column_name: "party_info_party_members_e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_info_party_members_pc_name_name", params_name: "pc_name_form", type: "text")

    params_to_form(params, @form_params, column_name: "battle_info_enemy_party_name_name", params_name: "enemy_party_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "party_info_name", params_name: "party_name_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_result_eq_any",
                             checkboxes: [{params_name: "result_win",   value: 1, first_checked: true},
                                          {params_name: "result_draw",  value: 0, first_checked: true},
                                          {params_name: "result_lose" , value: -1, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_info_is_boss_eq_any",
                             checkboxes: [{params_name: "is_encounter", value: 0, first_checked: false},
                                          {params_name: "is_boss" ,     value: 1, first_checked: false}])

    toggle_params_to_variable(params, @form_params, params_name: "show_member_num")
    toggle_params_to_variable(params, @form_params, params_name: "show_party_name")

  end
  # GET /battle_results/1
  #def show
  #end

  # GET /battle_results/new
  #def new
  #  @battle_result = BattleResult.new
  #end

  # GET /battle_results/1/edit
  #def edit
  #end

  # POST /battle_results
  #def create
  #  @battle_result = BattleResult.new(battle_result_params)

  #  if @battle_result.save
  #    redirect_to @battle_result, notice: "Battle result was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /battle_results/1
  #def update
  #  if @battle_result.update(battle_result_params)
  #    redirect_to @battle_result, notice: "Battle result was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /battle_results/1
  #def destroy
  #  @battle_result.destroy
  #  redirect_to battle_results_url, notice: "Battle result was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle_result
      @battle_result = BattleResult.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def battle_result_params
      params.require(:battle_result).permit(:result_no, :generate_no, :before_result_no, :before_generate_no, :party_no, :battle_result)
    end
end

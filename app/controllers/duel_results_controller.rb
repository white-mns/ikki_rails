class DuelResultsController < ApplicationController
  include MyUtility
  before_action :set_duel_result, only: [:show, :edit, :update, :destroy]

  # GET /duel_results
  def index
    placeholder_set
    param_set

    @count	= DuelResult.notnil().distinct.includes(:left_party_assault, :right_party_assault, [battle_info: [current_area: :area]], [left_party_info: [party_members: :pc_name]], [right_party_info: [party_members: :pc_name]]).search(params[:q]).result.hit_count()
    @search	= DuelResult.notnil().distinct.includes(:left_party_assault, :right_party_assault, [battle_info: [current_area: :area]], [left_party_info: [party_members: :pc_name]], [right_party_info: [party_members: :pc_name]]).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @duel_results	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "left_party_no", params_name: "left_party_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "right_party_no", params_name: "right_party_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_result", params_name: "battle_result_form", type: "number")

    params_to_form(params, @form_params, column_name: "left_party_info_member_num", params_name: "left_member_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "right_party_info_member_num", params_name: "right_member_num_form", type: "number")
    
    params_to_form(params, @form_params, column_name: "left_party_info_party_members_e_no_or_right_party_info_party_members_e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "left_party_info_party_members_pc_name_name_or_right_party_info_party_members_pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "left_party_info_name_or_right_party_info_name", params_name: "party_name_form", type: "text")

    params_to_form(params, @form_params, column_name: "battle_info_current_area_advance", params_name: "advance_form", type: "number")
  
    checkbox_params_set_query_any(params, @form_params, query_name: "left_party_assault_assault_type_or_right_party_assault_assault_type_eq_any",
                             checkboxes: [{params_name: "assault_1", value: 1, first_checked: false},
                                          {params_name: "assault_2", value: 2, first_checked: false},
                                          {params_name: "assault_3", value: 3, first_checked: false},
                                          {params_name: "assault_4", value: 4, first_checked: false},
                                          {params_name: "assault_5", value: 5, first_checked: false},
                                          {params_name: "assault_6", value: 6, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "left_party_info_member_num_eq_any",
                             checkboxes: [{params_name: "left_member_num_1", value: 1, first_checked: false},
                                          {params_name: "left_member_num_2", value: 2, first_checked: false},
                                          {params_name: "left_member_num_3", value: 3, first_checked: false},
                                          {params_name: "left_member_num_4", value: 4, first_checked: false}])
 
    checkbox_params_set_query_any(params, @form_params, query_name: "right_party_info_member_num_eq_any",
                             checkboxes: [{params_name: "right_member_num_1", value: 1, first_checked: false},
                                          {params_name: "right_member_num_2", value: 2, first_checked: false},
                                          {params_name: "right_member_num_3", value: 3, first_checked: false},
                                          {params_name: "right_member_num_4", value: 4, first_checked: false}])
     
    checkbox_params_set_query_any(params, @form_params, query_name: "battle_info_current_area_area_level_eq_any",
                             checkboxes: [{params_name: "level_1", value: 1, first_checked: false},
                                          {params_name: "level_2", value: 2, first_checked: false},
                                          {params_name: "level_3", value: 3, first_checked: false},
                                          {params_name: "level_4", value: 4, first_checked: false},
                                          {params_name: "level_5", value: 5, first_checked: false},
                                          {params_name: "level_6", value: 6, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_info_battle_type_eq_any",
                             checkboxes: [{params_name: "is_game", value: 0, first_checked: false},
                                          {params_name: "is_duel", value: 1, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_result_eq_any",
                             checkboxes: [{params_name: "result_win",   value: 1, first_checked: true},
                                          {params_name: "result_draw",  value: 0, first_checked: true},
                                          {params_name: "result_lose" , value: -1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_assault")
    toggle_params_to_variable(params, @form_params, params_name: "show_member_num")
    toggle_params_to_variable(params, @form_params, params_name: "show_party_name")
    toggle_params_to_variable(params, @form_params, params_name: "show_current_area")
  end
  # GET /duel_results/1
  #def show
  #end

  # GET /duel_results/new
  #def new
  #  @duel_result = DuelResult.new
  #end

  # GET /duel_results/1/edit
  #def edit
  #end

  # POST /duel_results
  #def create
  #  @duel_result = DuelResult.new(duel_result_params)

  #  if @duel_result.save
  #    redirect_to @duel_result, notice: "Duel result was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /duel_results/1
  #def update
  #  if @duel_result.update(duel_result_params)
  #    redirect_to @duel_result, notice: "Duel result was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /duel_results/1
  #def destroy
  #  @duel_result.destroy
  #  redirect_to duel_results_url, notice: "Duel result was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_duel_result
      @duel_result = DuelResult.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def duel_result_params
      params.require(:duel_result).permit(:result_no, :generate_no, :before_result_no, :before_generate_no, :left_party_no, :right_party_no, :battle_result)
    end
end

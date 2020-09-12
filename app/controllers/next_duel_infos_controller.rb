class NextDuelInfosController < ApplicationController
  include MyUtility
  before_action :set_next_duel_info, only: [:show, :edit, :update, :destroy]

  # GET /next_duel_infos
  def index
    placeholder_set
    param_set

    @count	= NextDuelInfo.notnil().distinct.includes([current_area: :area], [left_party_info: [party_members: :pc_name]], [right_party_info: [party_members: :pc_name]]).search(params[:q]).result.hit_count()
    @search	= NextDuelInfo.notnil().distinct.includes([current_area: :area], [left_party_info: [party_members: :pc_name]], [right_party_info: [party_members: :pc_name]]).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @next_duel_infos	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "left_party_no", params_name: "left_party_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "right_party_no", params_name: "right_party_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_type", params_name: "battle_type_form", type: "number")

    params_to_form(params, @form_params, column_name: "left_party_info_member_num", params_name: "left_member_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "right_party_info_member_num", params_name: "right_member_num_form", type: "number")

    params_to_form(params, @form_params, column_name: "left_party_info_party_members_e_no", params_name: "left_e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "left_party_info_party_members_pc_name_name", params_name: "left_pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "right_party_info_party_members_e_no", params_name: "right_e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "right_party_info_party_members_pc_name_name", params_name: "right_pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "left_party_info_party_members_e_no_or_right_party_info_party_members_e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "left_party_info_party_members_pc_name_name_or_right_party_info_party_members_pc_name_name", params_name: "pc_name_form", type: "text")

    params_to_form(params, @form_params, column_name: "left_party_info_name", params_name: "left_party_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "right_party_info_name", params_name: "right_party_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "left_party_info_name_or_right_party_info_name", params_name: "party_name_form", type: "text")

    params_to_form(params, @form_params, column_name: "current_area_advance", params_name: "advance_form", type: "number")
 
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
    
    checkbox_params_set_query_any(params, @form_params, query_name: "current_area_area_level_eq_any",
                             checkboxes: [{params_name: "level_1", value: 1, first_checked: false},
                                          {params_name: "level_2", value: 2, first_checked: false},
                                          {params_name: "level_3", value: 3, first_checked: false},
                                          {params_name: "level_4", value: 4, first_checked: false},
                                          {params_name: "level_5", value: 5, first_checked: false},
                                          {params_name: "level_6", value: 6, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_type_eq_any",
                             checkboxes: [{params_name: "is_game", value: 0, first_checked: true},
                                          {params_name: "is_duel" ,  value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_member_num")
    toggle_params_to_variable(params, @form_params, params_name: "show_party_name")
    toggle_params_to_variable(params, @form_params, params_name: "show_current_area")
  end
  # GET /next_duel_infos/1
  #def show
  #end

  # GET /next_duel_infos/new
  #def new
  #  @next_duel_info = NextDuelInfo.new
  #end

  # GET /next_duel_infos/1/edit
  #def edit
  #end

  # POST /next_duel_infos
  #def create
  #  @next_duel_info = NextDuelInfo.new(next_duel_info_params)

  #  if @next_duel_info.save
  #    redirect_to @next_duel_info, notice: "Next duel info was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /next_duel_infos/1
  #def update
  #  if @next_duel_info.update(next_duel_info_params)
  #    redirect_to @next_duel_info, notice: "Next duel info was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /next_duel_infos/1
  #def destroy
  #  @next_duel_info.destroy
  #  redirect_to next_duel_infos_url, notice: "Next duel info was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_next_duel_info
      @next_duel_info = NextDuelInfo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def next_duel_info_params
      params.require(:next_duel_info).permit(:result_no, :generate_no, :left_party_no, :right_party_no, :battle_type)
    end
end

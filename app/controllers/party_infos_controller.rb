class PartyInfosController < ApplicationController
  include MyUtility
  before_action :set_party_info, only: [:show, :edit, :update, :destroy]

  # GET /party_infos
  def index
    placeholder_set
    param_set

    @count	= PartyInfo.notnil().includes([party_members: :pc_name], current_area: :area).search(params[:q]).result.hit_count()
    @search	= PartyInfo.notnil().includes([party_members: :pc_name], current_area: :area).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @party_infos	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "party_type", params_name: "party_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "number")
    params_to_form(params, @form_params, column_name: "member_num", params_name: "member_num_form", type: "number")

    params_to_form(params, @form_params, column_name: "party_members_e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_members_pc_name_name", params_name: "pc_name_form", type: "text")

    params_to_form(params, @form_params, column_name: "current_area_area_name", params_name: "area_form", type: "text")
    params_to_form(params, @form_params, column_name: "current_area_advance", params_name: "advance_form", type: "number")
    params_to_form(params, @form_params, column_name: "current_area_bellicosity", params_name: "bellicosity_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "member_num_eq_any",
                             checkboxes: [{params_name: "member_num_1", value: 1, first_checked: false},
                                          {params_name: "member_num_2", value: 2, first_checked: false},
                                          {params_name: "member_num_3", value: 3, first_checked: false},
                                          {params_name: "member_num_4", value: 4, first_checked: false}])
 
    checkbox_params_set_query_any(params, @form_params, query_name: "party_type_eq_any",
                             checkboxes: [{params_name: "is_battle", value: 0},
                                          {params_name: "is_next" ,  value: 1, first_checked: true}])
 
    checkbox_params_set_query_any(params, @form_params, query_name: "current_area_area_level_eq_any",
                             checkboxes: [{params_name: "level_1", value: 1, first_checked: false},
                                          {params_name: "level_2", value: 2, first_checked: false},
                                          {params_name: "level_3", value: 3, first_checked: false},
                                          {params_name: "level_4", value: 4, first_checked: false},
                                          {params_name: "level_5", value: 5, first_checked: false},
                                          {params_name: "level_6", value: 6, first_checked: false}])

    toggle_params_to_variable(params, @form_params, params_name: "show_current_area")
  end
  # GET /party_infos/1
  #def show
  #end

  # GET /party_infos/new
  #def new
  #  @party_info = PartyInfo.new
  #end

  # GET /party_infos/1/edit
  #def edit
  #end

  # POST /party_infos
  #def create
  #  @party_info = PartyInfo.new(party_info_params)

  #  if @party_info.save
  #    redirect_to @party_info, notice: "Party info was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /party_infos/1
  #def update
  #  if @party_info.update(party_info_params)
  #    redirect_to @party_info, notice: "Party info was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /party_infos/1
  #def destroy
  #  @party_info.destroy
  #  redirect_to party_infos_url, notice: "Party info was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_party_info
      @party_info = PartyInfo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def party_info_params
      params.require(:party_info).permit(:result_no, :generate_no, :party_no, :party_type, :name, :member_num)
    end
end

class PkDataController < ApplicationController
  include MyUtility
  before_action :set_pk_datum, only: [:show, :edit, :update, :destroy]

  # GET /pk_data
  def index
    placeholder_set
    param_set

    @count	= PkDatum.notnil().distinct.includes(:pc_name, :status, [party: [party_info: [current_area: :area]]]).search(params[:q]).result.hit_count()
    @search	= PkDatum.notnil().distinct.includes(:pc_name, :status, [party: [party_info: [current_area: :area]]]).page(params[:page]).search(params[:q])
    @search.sorts = "e_no asc" if @search.sorts.empty?
    @pk_data	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "pk_num", params_name: "pk_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "pk_win_num", params_name: "pk_win_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "latest_pk_result_no", params_name: "latest_pk_result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "pkk_num", params_name: "pkk_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "pkk_win_num", params_name: "pkk_win_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "latest_pkk_result_no", params_name: "latest_pkk_result_no_form", type: "number")

    params_to_form(params, @form_params, column_name: "status_clv", params_name: "clv_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_ps", params_name: "ps_form", type: "number")

    params_to_form(params, @form_params, column_name: "party_party_info_current_area_area_name", params_name: "area_form", type: "text")
    params_to_form(params, @form_params, column_name: "party_party_info_current_area_advance", params_name: "advance_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_party_info_current_area_bellicosity", params_name: "bellicosity_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "party_party_info_member_num_eq_any",
                             checkboxes: [{params_name: "member_num_1", value: 1, first_checked: false},
                                          {params_name: "member_num_2", value: 2, first_checked: false},
                                          {params_name: "member_num_3", value: 3, first_checked: false},
                                          {params_name: "member_num_4", value: 4, first_checked: false}])
 
    checkbox_params_set_query_any(params, @form_params, query_name: "party_party_info_current_area_area_level_eq_any",
                             checkboxes: [{params_name: "level_1", value: 1, first_checked: false},
                                          {params_name: "level_2", value: 2, first_checked: false},
                                          {params_name: "level_3", value: 3, first_checked: false},
                                          {params_name: "level_4", value: 4, first_checked: false},
                                          {params_name: "level_5", value: 5, first_checked: false},
                                          {params_name: "level_6", value: 6, first_checked: false}])

    toggle_params_to_variable(params, @form_params, params_name: "show_pkk")
    toggle_params_to_variable(params, @form_params, params_name: "show_current_area")
  end
  # GET /pk_data/1
  #def show
  #end

  # GET /pk_data/new
  #def new
  #  @pk_datum = PkDatum.new
  #end

  # GET /pk_data/1/edit
  #def edit
  #end

  # POST /pk_data
  #def create
  #  @pk_datum = PkDatum.new(pk_datum_params)

  #  if @pk_datum.save
  #    redirect_to @pk_datum, notice: "Pk datum was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /pk_data/1
  #def update
  #  if @pk_datum.update(pk_datum_params)
  #    redirect_to @pk_datum, notice: "Pk datum was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /pk_data/1
  #def destroy
  #  @pk_datum.destroy
  #  redirect_to pk_data_url, notice: "Pk datum was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pk_datum
      @pk_datum = PkDatum.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pk_datum_params
      params.require(:pk_datum).permit(:result_no, :generate_no, :e_no, :pk_num, :pk_win_num, :latest_pk_result_no, :pkk_num, :pkk_win_num, :latest_pkk_result_no)
    end
end

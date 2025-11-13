class CurrentAreasController < ApplicationController
  include MyUtility
  before_action :set_current_area, only: [:show, :edit, :update, :destroy]

  # GET /current_areas
  def index
    placeholder_set
    param_set

    @count	= CurrentArea.notnil().includes(:pc_name, :area).ransack(params[:q]).result.hit_count()
    @search	= CurrentArea.notnil().includes(:pc_name, :area).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @current_areas	= @search.result.per(50)
  end

  # GET /current_area/totals
  def total
    placeholder_set
    param_set

    @count	= CurrentArea.notnil().includes(:pc_name, :area).ransack(params[:q]).result.hit_count()

    @area_search = CurrentArea.notnil().includes(:pc_name, :area).group(:area_id).ransack(params[:q])
    @area_search.sorts = "area_id asc" if @area_search.sorts.empty?
    @areas	= @area_search.result

    @search	= CurrentArea.notnil().includes(:pc_name, :area).ransack(params[:q])
    @search.sorts = "area_id asc" if @search.sorts.empty?
    @current_areas	= @search.result.area_total()
  end

  # GET /pk_histories
  def pk
    placeholder_set
    param_set

    params_pk_data = Marshal.load(Marshal.dump(params))
    params_pk_data[:q]["result_no_eq"] = sprintf("%d",@latest_result)

    @search_pk_data	= PkDatum.notnil().distinct.includes(:pc_name, :old_pc_name, :status, [next_battle_party: [party_info: [current_area: :area],]]).page(params_pk_data[:page]).ransack(params_pk_data[:q])
    @search_pk_data.sorts = "e_no asc" if @search_pk_data.sorts.empty?
    @pk_data	= @search_pk_data.result.per(5)

    @count	= CurrentArea.notnil().includes(:pc_name, :area, :assault, :pk_result, [next_duel_party: [party_info: [party_members: :pc_name]]], [next_battle_party: [party_info: [party_members: :pc_name]]]).ransack(params[:q]).result.hit_count()
    @search	= CurrentArea.notnil().includes(:pc_name, :area, :assault, :pk_result, [next_duel_party: [party_info: [party_members: :pc_name]]], [next_battle_party: [party_info: [party_members: :pc_name]]]).page(params[:page]).ransack(params[:q])
    @search.sorts = "result_no asc" if @search.sorts.empty?
    @current_areas	= @search.result.per(100)
  end



  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        if action_name != "pk"then
            params["result_no_form"] ||= sprintf("%d",@latest_result)
        else
            params["result_no_form"] ||= sprintf("~%d",@latest_result)
        end
    end
    if action_name == "pk"then
        @pk_data_eno = PkDatum.notnil().distinct.pluck(:e_no)
        params[:q][:pc_name_e_no_eq_any] = @pk_data_eno
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "area_id", params_name: "area_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "advance", params_name: "advance_form", type: "number")
    params_to_form(params, @form_params, column_name: "bellicosity", params_name: "bellicosity_form", type: "number")

    params_to_form(params, @form_params, column_name: "area_name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "area_level", params_name: "level_form", type: "number")
    
    checkbox_params_set_query_any(params, @form_params, query_name: "area_level_eq_any",
                             checkboxes: [{params_name: "level_1", value: 1, first_checked: false},
                                          {params_name: "level_2", value: 2, first_checked: false},
                                          {params_name: "level_3", value: 3, first_checked: false},
                                          {params_name: "level_4", value: 4, first_checked: false},
                                          {params_name: "level_5", value: 5, first_checked: false},
                                          {params_name: "level_6", value: 6, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "pk_result_battle_result_eq_any",
                             checkboxes: [{params_name: "result_win",   value: 1, first_checked: false},
                                          {params_name: "result_draw",  value: 0, first_checked: false},
                                          {params_name: "result_lose" , value: -1, first_checked: false}])
 
    checkbox_params_set_query_any(params, @form_params, query_name: "assault_assault_type_eq_any",
                             checkboxes: [{params_name: "assault_1", value: 1, first_checked: false},
                                          {params_name: "assault_2", value: 2, first_checked: false},
                                          {params_name: "assault_3", value: 3, first_checked: false},
                                          {params_name: "assault_4", value: 4, first_checked: false},
                                          {params_name: "assault_5", value: 5, first_checked: false},
                                          {params_name: "assault_6", value: 6, first_checked: false}])

    toggle_params_to_variable(params, @form_params, params_name: "show_current_area")
    toggle_params_to_variable(params, @form_params, params_name: "show_battle_result")
    toggle_params_to_variable(params, @form_params, params_name: "show_assault")
  end
  # GET /current_areas/1
  #def show
  #end

  # GET /current_areas/new
  #def new
  #  @current_area = CurrentArea.new
  #end

  # GET /current_areas/1/edit
  #def edit
  #end

  # POST /current_areas
  #def create
  #  @current_area = CurrentArea.new(current_area_params)

  #  if @current_area.save
  #    redirect_to @current_area, notice: "Current area was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /current_areas/1
  #def update
  #  if @current_area.update(current_area_params)
  #    redirect_to @current_area, notice: "Current area was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /current_areas/1
  #def destroy
  #  @current_area.destroy
  #  redirect_to current_areas_url, notice: "Current area was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_area
      @current_area = CurrentArea.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def current_area_params
      params.require(:current_area).permit(:result_no, :generate_no, :e_no, :area_id, :advance, :bellicosity)
    end
end

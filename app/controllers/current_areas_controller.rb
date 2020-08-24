class CurrentAreasController < ApplicationController
  include MyUtility
  before_action :set_current_area, only: [:show, :edit, :update, :destroy]

  # GET /current_areas
  def index
    placeholder_set
    param_set

    @count	= CurrentArea.notnil().includes(:pc_name, :area).search(params[:q]).result.hit_count()
    @search	= CurrentArea.notnil().includes(:pc_name, :area).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @current_areas	= @search.result.per(50)
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

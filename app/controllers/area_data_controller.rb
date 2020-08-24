class AreaDataController < ApplicationController
  include MyUtility
  before_action :set_area_datum, only: [:show, :edit, :update, :destroy]

  # GET /area_data
  def index
    placeholder_set
    param_set

    @count	= AreaDatum.search(params[:q]).result.hit_count()
    @search	= AreaDatum.page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @area_data	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "area_id", params_name: "area_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "level", params_name: "level_form", type: "number")
    
    checkbox_params_set_query_any(params, @form_params, query_name: "level_eq_any",
                             checkboxes: [{params_name: "level_1", value: 1, first_checked: false},
                                          {params_name: "level_2", value: 2, first_checked: false},
                                          {params_name: "level_3", value: 3, first_checked: false},
                                          {params_name: "level_4", value: 4, first_checked: false},
                                          {params_name: "level_5", value: 5, first_checked: false},
                                          {params_name: "level_6", value: 6, first_checked: false}])
  end
  # GET /area_data/1
  #def show
  #end

  # GET /area_data/new
  #def new
  #  @area_datum = AreaDatum.new
  #end

  # GET /area_data/1/edit
  #def edit
  #end

  # POST /area_data
  #def create
  #  @area_datum = AreaDatum.new(area_datum_params)

  #  if @area_datum.save
  #    redirect_to @area_datum, notice: "Area datum was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /area_data/1
  #def update
  #  if @area_datum.update(area_datum_params)
  #    redirect_to @area_datum, notice: "Area datum was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /area_data/1
  #def destroy
  #  @area_datum.destroy
  #  redirect_to area_data_url, notice: "Area datum was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area_datum
      @area_datum = AreaDatum.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def area_datum_params
      params.require(:area_datum).permit(:area_id, :name, :level)
    end
end

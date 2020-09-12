class AssaultsController < ApplicationController
  include MyUtility
  before_action :set_assault, only: [:show, :edit, :update, :destroy]

  # GET /assaults
  def index
    placeholder_set
    param_set

    @count	= Assault.notnil().includes(:pc_name).search(params[:q]).result.hit_count()
    @search	= Assault.notnil().includes(:pc_name).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @assaults	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "assault_type", params_name: "assault_type_form", type: "number")
 
    checkbox_params_set_query_any(params, @form_params, query_name: "assault_type_eq_any",
                             checkboxes: [{params_name: "assault_1", value: 1, first_checked: false},
                                          {params_name: "assault_2", value: 2, first_checked: false},
                                          {params_name: "assault_3", value: 3, first_checked: false},
                                          {params_name: "assault_4", value: 4, first_checked: false},
                                          {params_name: "assault_5", value: 5, first_checked: false},
                                          {params_name: "assault_6", value: 6, first_checked: false}])


  end
  # GET /assaults/1
  #def show
  #end

  # GET /assaults/new
  #def new
  #  @assault = Assault.new
  #end

  # GET /assaults/1/edit
  #def edit
  #end

  # POST /assaults
  #def create
  #  @assault = Assault.new(assault_params)

  #  if @assault.save
  #    redirect_to @assault, notice: "Assault was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /assaults/1
  #def update
  #  if @assault.update(assault_params)
  #    redirect_to @assault, notice: "Assault was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /assaults/1
  #def destroy
  #  @assault.destroy
  #  redirect_to assaults_url, notice: "Assault was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assault
      @assault = Assault.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def assault_params
      params.require(:assault).permit(:result_no, :generate_no, :e_no, :assault_type)
    end
end

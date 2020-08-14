class ProductionsController < ApplicationController
  include MyUtility
  before_action :set_production, only: [:show, :edit, :update, :destroy]

  # GET /productions
  def index
    placeholder_set
    param_set

    @count	= Production.notnil().includes(:pc_name).search(params[:q]).result.hit_count()
    @search	= Production.notnil().includes(:pc_name).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @productions	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "cook", params_name: "cook_form", type: "number")
    params_to_form(params, @form_params, column_name: "make", params_name: "make_form", type: "number")
    params_to_form(params, @form_params, column_name: "composition", params_name: "composition_form", type: "number")
    params_to_form(params, @form_params, column_name: "addition", params_name: "addition_form", type: "number")
  end
  # GET /productions/1
  #def show
  #end

  # GET /productions/new
  #def new
  #  @production = Production.new
  #end

  # GET /productions/1/edit
  #def edit
  #end

  # POST /productions
  #def create
  #  @production = Production.new(production_params)

  #  if @production.save
  #    redirect_to @production, notice: "Production was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /productions/1
  #def update
  #  if @production.update(production_params)
  #    redirect_to @production, notice: "Production was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /productions/1
  #def destroy
  #  @production.destroy
  #  redirect_to productions_url, notice: "Production was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_production
      @production = Production.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def production_params
      params.require(:production).permit(:result_no, :generate_no, :e_no, :cook, :make, :composition, :addition)
    end
end

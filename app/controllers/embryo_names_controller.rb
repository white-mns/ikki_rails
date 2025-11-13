class EmbryoNamesController < ApplicationController
  include MyUtility
  before_action :set_embryo_name, only: [:show, :edit, :update, :destroy]

  # GET /embryo_names
  def index
    placeholder_set
    param_set

    @count	= EmbryoName.ransack(params[:q]).result.hit_count()
    @search	= EmbryoName.page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @embryo_names	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "embryo_id", params_name: "embryo_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
  end
  # GET /embryo_names/1
  #def show
  #end

  # GET /embryo_names/new
  #def new
  #  @embryo_name = EmbryoName.new
  #end

  # GET /embryo_names/1/edit
  #def edit
  #end

  # POST /embryo_names
  #def create
  #  @embryo_name = EmbryoName.new(embryo_name_params)

  #  if @embryo_name.save
  #    redirect_to @embryo_name, notice: "Embryo name was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /embryo_names/1
  #def update
  #  if @embryo_name.update(embryo_name_params)
  #    redirect_to @embryo_name, notice: "Embryo name was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /embryo_names/1
  #def destroy
  #  @embryo_name.destroy
  #  redirect_to embryo_names_url, notice: "Embryo name was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_embryo_name
      @embryo_name = EmbryoName.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def embryo_name_params
      params.require(:embryo_name).permit(:embryo_id, :name)
    end
end

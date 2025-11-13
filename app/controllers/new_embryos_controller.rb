class NewEmbryosController < ApplicationController
  include MyUtility
  before_action :set_new_embryo, only: [:show, :edit, :update, :destroy]

  # GET /new_embryos
  def index
    placeholder_set
    param_set

    @count	= NewEmbryo.notnil().includes(:embryo).ransack(params[:q]).result.hit_count()
    @search	= NewEmbryo.notnil().includes(:embryo).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @new_embryos	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("~%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "embryo_id", params_name: "embryo_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "embryo_name", params_name: "embryo_form", type: "text")
  end
  # GET /new_embryos/1
  #def show
  #end

  # GET /new_embryos/new
  #def new
  #  @new_embryo = NewEmbryo.new
  #end

  # GET /new_embryos/1/edit
  #def edit
  #end

  # POST /new_embryos
  #def create
  #  @new_embryo = NewEmbryo.new(new_embryo_params)

  #  if @new_embryo.save
  #    redirect_to @new_embryo, notice: "New embryo was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /new_embryos/1
  #def update
  #  if @new_embryo.update(new_embryo_params)
  #    redirect_to @new_embryo, notice: "New embryo was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /new_embryos/1
  #def destroy
  #  @new_embryo.destroy
  #  redirect_to new_embryos_url, notice: "New embryo was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_embryo
      @new_embryo = NewEmbryo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def new_embryo_params
      params.require(:new_embryo).permit(:result_no, :generate_no, :embryo_id)
    end
end

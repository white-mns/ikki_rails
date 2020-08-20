class NewItemsController < ApplicationController
  include MyUtility
  before_action :set_new_item, only: [:show, :edit, :update, :destroy]

  # GET /new_items
  def index
    placeholder_set
    param_set

    @count	= NewItem.notnil().includes(:item).search(params[:q]).result.hit_count()
    @search	= NewItem.notnil().includes(:item).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @new_items	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")

    params_to_form(params, @form_params, column_name: "item_strength", params_name: "strength_form", type: "number")
  end
  # GET /new_items/1
  #def show
  #end

  # GET /new_items/new
  #def new
  #  @new_item = NewItem.new
  #end

  # GET /new_items/1/edit
  #def edit
  #end

  # POST /new_items
  #def create
  #  @new_item = NewItem.new(new_item_params)

  #  if @new_item.save
  #    redirect_to @new_item, notice: "New item was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /new_items/1
  #def update
  #  if @new_item.update(new_item_params)
  #    redirect_to @new_item, notice: "New item was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /new_items/1
  #def destroy
  #  @new_item.destroy
  #  redirect_to new_items_url, notice: "New item was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_item
      @new_item = NewItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def new_item_params
      params.require(:new_item).permit(:result_no, :generate_no, :name)
    end
end

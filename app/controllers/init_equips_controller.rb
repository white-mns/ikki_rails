class InitEquipsController < ApplicationController
  include MyUtility
  before_action :set_init_equip, only: [:show, :edit, :update, :destroy]

  # GET /init_equips
  def index
    placeholder_set
    param_set

    @count	= InitEquip.notnil().includes(:pc_name, item: [:kind, :effect_1, :effect_2, :effect_3]).search(params[:q]).result.hit_count()
    @search	= InitEquip.notnil().includes(:pc_name, item: [:kind, :effect_1, :effect_2, :effect_3]).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @init_equips	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "i_no", params_name: "i_no_form", type: "number")
    
    params_to_form(params, @form_params, column_name: "item_name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "item_strength", params_name: "strength_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_kind_name", params_name: "kind_form", type: "text")
    params_to_form(params, @form_params, column_name: "item_effect_1_name_or_item_effect_2_name_or_item_effect_3_name", params_name: "effect_form", type: "text")
    params_to_form(params, @form_params, column_name: "item_effect_1_name", params_name: "effect_1_form", type: "text")
    params_to_form(params, @form_params, column_name: "item_effect_2_name", params_name: "effect_2_form", type: "text")
    params_to_form(params, @form_params, column_name: "item_effect_3_name", params_name: "effect_3_form", type: "text")
    params_to_form(params, @form_params, column_name: "item_effect_1_value", params_name: "effect_1_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_effect_2_value", params_name: "effect_2_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_effect_3_value", params_name: "effect_3_value_form", type: "number")
    
    checkbox_params_set_query_single(params, @form_params,
                             checkbox: {params_name: "ruri_raru_ng", query_name: "item_i_no_lteq", value: 3, first_checked: false})

    toggle_params_to_variable(params, @form_params, params_name: "show_item")
    toggle_params_to_variable(params, @form_params, params_name: "show_fuka")
  end
  # GET /init_equips/1
  #def show
  #end

  # GET /init_equips/new
  #def new
  #  @init_equip = InitEquip.new
  #end

  # GET /init_equips/1/edit
  #def edit
  #end

  # POST /init_equips
  #def create
  #  @init_equip = InitEquip.new(init_equip_params)

  #  if @init_equip.save
  #    redirect_to @init_equip, notice: "Init equip was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /init_equips/1
  #def update
  #  if @init_equip.update(init_equip_params)
  #    redirect_to @init_equip, notice: "Init equip was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /init_equips/1
  #def destroy
  #  @init_equip.destroy
  #  redirect_to init_equips_url, notice: "Init equip was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_init_equip
      @init_equip = InitEquip.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def init_equip_params
      params.require(:init_equip).permit(:result_no, :generate_no, :e_no, :i_no)
    end
end

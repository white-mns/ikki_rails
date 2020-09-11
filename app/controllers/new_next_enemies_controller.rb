class NewNextEnemiesController < ApplicationController
  include MyUtility
  before_action :set_new_next_enemy, only: [:show, :edit, :update, :destroy]

  # GET /new_next_enemies
  def index
    placeholder_set
    param_set

    @count	= NewNextEnemy.notnil().includes(:enemy, :area).search(params[:q]).result.hit_count()
    @search	= NewNextEnemy.notnil().includes(:enemy, :area).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @new_next_enemies	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "enemy_id", params_name: "enemy_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "is_boss", params_name: "is_boss_form", type: "number")
    params_to_form(params, @form_params, column_name: "advance", params_name: "advance_form", type: "number")

    params_to_form(params, @form_params, column_name: "enemy_name", params_name: "enemy_form", type: "number")

    params_to_form(params, @form_params, column_name: "area_name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "area_level", params_name: "level_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "is_boss_eq_any",
                             checkboxes: [{params_name: "is_encounter", value: 0, first_checked: false},
                                          {params_name: "is_boss" ,     value: 1, first_checked: false}])
    
    checkbox_params_set_query_any(params, @form_params, query_name: "area_level_eq_any",
                             checkboxes: [{params_name: "level_1", value: 1, first_checked: false},
                                          {params_name: "level_2", value: 2, first_checked: false},
                                          {params_name: "level_3", value: 3, first_checked: false},
                                          {params_name: "level_4", value: 4, first_checked: false},
                                          {params_name: "level_5", value: 5, first_checked: false},
                                          {params_name: "level_6", value: 6, first_checked: false}])
  end
  # GET /new_next_enemies/1
  #def show
  #end

  # GET /new_next_enemies/new
  #def new
  #  @new_next_enemy = NewNextEnemy.new
  #end

  # GET /new_next_enemies/1/edit
  #def edit
  #end

  # POST /new_next_enemies
  #def create
  #  @new_next_enemy = NewNextEnemy.new(new_next_enemy_params)

  #  if @new_next_enemy.save
  #    redirect_to @new_next_enemy, notice: "New next enemy was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /new_next_enemies/1
  #def update
  #  if @new_next_enemy.update(new_next_enemy_params)
  #    redirect_to @new_next_enemy, notice: "New next enemy was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /new_next_enemies/1
  #def destroy
  #  @new_next_enemy.destroy
  #  redirect_to new_next_enemies_url, notice: "New next enemy was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_next_enemy
      @new_next_enemy = NewNextEnemy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def new_next_enemy_params
      params.require(:new_next_enemy).permit(:result_no, :generate_no, :enemy_id, :is_boss, :area_id, :advance)
    end
end

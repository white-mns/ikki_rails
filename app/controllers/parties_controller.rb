class PartiesController < ApplicationController
  include MyUtility
  before_action :set_party, only: [:show, :edit, :update, :destroy]

  # GET /parties
  def index
    placeholder_set
    param_set

    @count	= Party.notnil().includes(:pc_name).search(params[:q]).result.hit_count()
    @search	= Party.notnil().includes(:pc_name).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @parties	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "party_type", params_name: "party_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_no", params_name: "party_no_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "party_type_eq_any",
                             checkboxes: [{params_name: "is_battle", value: 0, first_checked: true},
                                          {params_name: "is_next" ,  value: 1, first_checked: true}])
  end
  # GET /parties/1
  #def show
  #end

  # GET /parties/new
  #def new
  #  @party = Party.new
  #end

  # GET /parties/1/edit
  #def edit
  #end

  # POST /parties
  #def create
  #  @party = Party.new(party_params)

  #  if @party.save
  #    redirect_to @party, notice: "Party was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /parties/1
  #def update
  #  if @party.update(party_params)
  #    redirect_to @party, notice: "Party was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /parties/1
  #def destroy
  #  @party.destroy
  #  redirect_to parties_url, notice: "Party was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_party
      @party = Party.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def party_params
      params.require(:party).permit(:result_no, :generate_no, :e_no, :party_type, :party_no)
    end
end

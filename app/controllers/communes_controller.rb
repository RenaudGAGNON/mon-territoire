class CommunesController < ApplicationController

  before_action :set_all_communes
  before_action :set_commune, only: %w(show update)

  def index
    respond_to do |format|
      format.json { render json: @all_communes }
      format.html { render html: "", status: :not_acceptable }
    end
  end

  def create
    render html: "", status: :forbidden
  end

  def show
    return not_found unless @commune 
    render html: "", status: :ok
  end

  def update
    return not_found unless @commune 
    return unless commune_params
    @commune.update(commune_params)
    render html: "", status: :no_content
  end

  private

  def not_found
    render html: "", status: :not_found
  end

  def bad_request
    render html: "", status: :bad_request
  end

  def commune_params
    begin 
      params.require(:commune).permit(:name, :code_insee)
    rescue
      bad_request and return
    end
  end

  def set_all_communes
    @all_communes = Commune.all
  end

  def set_commune
    @commune = @all_communes.where(code_insee: params[:id]).try(:take)
  end
end

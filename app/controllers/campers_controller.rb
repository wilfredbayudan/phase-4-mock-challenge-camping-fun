class CampersController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    campers = Camper.all
    render json: campers.to_json(only: [:id, :name, :age])
  end

  def show
    camper = Camper.find(params[:id])
    render json: camper
  end

  def create
    camper = Camper.create!(camper_params)
    render json: camper, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  private

  def camper_params
    params.permit(:name, :age)
  end

  def render_not_found_response
    render json: { error: "Camper not found" }, status: :not_found
  end


end

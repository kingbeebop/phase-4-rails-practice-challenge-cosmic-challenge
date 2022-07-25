class MissionsController < ApplicationController
  before_action :set_mission, only: %i[ show update destroy ]

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /missions
  def index
    @missions = Mission.all

    render json: @missions
  end

  # GET /missions/1
  def show
    render json: @mission
  end

  # POST /missions
  # def create
  #   @mission = Mission.new(mission_params)

  #   if @mission.save!
  #     render json: @mission.planet, status: :created
  #   else
  #     render json: @mission.errors, status: :unprocessable_entity
  #   end
  # end

  def create
    mission = Mission.create!(mission_params)
    render json: mission.planet, status: :created
  end

  # PATCH/PUT /missions/1
  # def update
  #   if @mission.update(mission_params)
  #     render json: @mission
  #   else
  #     render json: @mission.errors, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /missions/1
  # def destroy
  #   @mission.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mission
      @mission = Mission.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mission_params
      params.permit(:name, :scientist_id, :planet_id)
    end

    def render_unprocessable_entity_response(exception)
      render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
  
    def render_not_found_response
      render json: { error: "Mission not found" }, status: :not_found
    end
end

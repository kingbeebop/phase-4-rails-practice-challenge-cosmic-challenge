class ScientistsController < ApplicationController
  before_action :set_scientist, only: %i[ show update destroy ]

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /scientists
  def index
    @scientists = Scientist.all

    render json: @scientists
  end

  # GET /scientists/1
  def show
    render json: @scientist, serializer: ScientistWithPlanetsSerializer
  end

  # POST /scientists
  def create
    @scientist = Scientist.new(scientist_params)

    if @scientist.save!
      render json: @scientist, status: :created
    else
      render json: @scientist.errors, status: :unprocessable_entity
    end
  end

  # def create
  #   @scientist = Scientist.create!(scientist_params)
  #   render json: @scientist, status: :created
  # end

  # PATCH/PUT /scientists/1
  def update
    if @scientist.update!(scientist_params)
      render json: @scientist, status: :accepted
    else
      render json: @scientist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /scientists/1
  def destroy
    @scientist.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scientist
      @scientist = Scientist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def scientist_params
      params.permit(:name, :field_of_study, :avatar)
    end

    def render_unprocessable_entity_response(exception)
      render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_not_found_response
      render json: { error: "Scientist not found" }, status: :not_found
    end
end

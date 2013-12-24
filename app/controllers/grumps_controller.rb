class GrumpsController < ApplicationController
  before_action :set_grump, only: [:show, :edit, :update, :destroy]

  # GET /grumps
  def index
    @grumps = Grump.all
  end

  # GET /grumps/1
  def show
  end

  # GET /grumps/new
  def new
    @grump = Grump.new
  end

  # GET /grumps/1/edit
  def edit
  end

  # POST /grumps
  def create
    @grump = Grump.new(grump_params)

    if @grump.save
      redirect_to @grump, notice: 'Grump was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /grumps/1
  def update
    if @grump.update(grump_params)
      redirect_to @grump, notice: 'Grump was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /grumps/1
  def destroy
    @grump.destroy
    redirect_to grumps_url, notice: 'Grump was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grump
      @grump = Grump.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def grump_params
      params.require(:grump).permit(:name, :published_at)
    end
end

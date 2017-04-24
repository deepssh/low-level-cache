class SlowJobsController < ApplicationController
  before_action :set_slow_job, only: [:show, :edit, :update, :destroy]

  # GET /slow_jobs
  # GET /slow_jobs.json
  def index
    @slow_jobs = SlowJob.all
  end

  # GET /slow_jobs/1
  # GET /slow_jobs/1.json
  def show
  end

  # GET /slow_jobs/new
  def new
    @slow_job = SlowJob.new
  end

  # GET /slow_jobs/1/edit
  def edit
  end

  # POST /slow_jobs
  # POST /slow_jobs.json
  def create
    @slow_job = SlowJob.new(slow_job_params)

    respond_to do |format|
      if @slow_job.save
        format.html { redirect_to @slow_job, notice: 'Slow job was successfully created.' }
        format.json { render :show, status: :created, location: @slow_job }
      else
        format.html { render :new }
        format.json { render json: @slow_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slow_jobs/1
  # PATCH/PUT /slow_jobs/1.json
  def update
    respond_to do |format|
      if @slow_job.update(slow_job_params)
        format.html { redirect_to @slow_job, notice: 'Slow job was successfully updated.' }
        format.json { render :show, status: :ok, location: @slow_job }
      else
        format.html { render :edit }
        format.json { render json: @slow_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slow_jobs/1
  # DELETE /slow_jobs/1.json
  def destroy
    @slow_job.destroy
    respond_to do |format|
      format.html { redirect_to slow_jobs_url, notice: 'Slow job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slow_job
      @slow_job = SlowJob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slow_job_params
      params.require(:slow_job).permit(:name, :requested_time, :returned_at, :description)
    end
end

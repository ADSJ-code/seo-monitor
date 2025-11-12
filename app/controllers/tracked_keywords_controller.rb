class TrackedKeywordsController < ApplicationController
  before_action :set_tracked_keyword, only: %i[ show edit update destroy check_rank ]

  # GET /tracked_keywords or /tracked_keywords.json
  def index
    @tracked_keywords = TrackedKeyword.all
  end

  # GET /tracked_keywords/1 or /tracked_keywords/1.json
  def show
    @ranking_histories = @tracked_keyword.ranking_histories.order(checked_on: :desc)
  end

  # GET /tracked_keywords/new
  def new
    @tracked_keyword = TrackedKeyword.new
  end

  # GET /tracked_keywords/1/edit
  def edit
  end

  # POST /tracked_keywords or /tracked_keywords.json
  # POST /tracked_keywords or /tracked_keywords.json
  def create
    @tracked_keyword = TrackedKeyword.new(tracked_keyword_params)

    respond_to do |format|
      if @tracked_keyword.save
        # ## ADICIONE A NOSSA LINHA AQUI ##
        # Envia o job para o Sidekiq executar em segundo plano
        SeoCheckWorker.perform_async(@tracked_keyword.id.to_s)

        format.html { redirect_to @tracked_keyword, notice: "Tracked keyword was successfully created. Checking rank in the background." }
        format.json { render :show, status: :created, location: @tracked_keyword }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tracked_keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tracked_keywords/1 or /tracked_keywords/1.json
  def update
    respond_to do |format|
      if @tracked_keyword.update(tracked_keyword_params)
        format.html { redirect_to @tracked_keyword, notice: "Tracked keyword was successfully updated." }
        format.json { render :show, status: :ok, location: @tracked_keyword }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tracked_keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tracked_keywords/1 or /tracked_keywords/1.json
  def destroy
    @tracked_keyword.destroy!

    respond_to do |format|
      format.html { redirect_to tracked_keywords_path, status: :see_other, notice: "Tracked keyword was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def check_rank
    SeoCheckWorker.perform_async(@tracked_keyword.id.to_s)
    head :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tracked_keyword
      @tracked_keyword = TrackedKeyword.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def tracked_keyword_params
      # CORREÇÃO: Adicionamos :gl e :hl
      params.expect(tracked_keyword: [ :keyword, :domain, :gl, :hl ])
    end
end
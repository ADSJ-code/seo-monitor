class TrackedKeywordsController < ApplicationController
  before_action :set_tracked_keyword, only: %i[ show edit update destroy check_ranking ]

  def index
    @tracked_keywords = TrackedKeyword.all
  end

  def show
  end

  def new
    @tracked_keyword = TrackedKeyword.new
  end

  def edit
  end

  def create
    @tracked_keyword = TrackedKeyword.new(tracked_keyword_params)

    if @tracked_keyword.save
      SeoCheckWorker.perform_async(@tracked_keyword.id.to_s)
      redirect_to @tracked_keyword, notice: "Palavra-chave criada. Verificação de ranking em progresso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @tracked_keyword.update(tracked_keyword_params)
      SeoCheckWorker.perform_async(@tracked_keyword.id.to_s)
      redirect_to @tracked_keyword, notice: "Palavra-chave atualizada. Re-verificando o ranking."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tracked_keyword.destroy!
    redirect_to tracked_keywords_url, notice: "Palavra-chave removida."
  end

  def check_ranking
    SeoCheckWorker.perform_async(@tracked_keyword.id.to_s)
    redirect_to @tracked_keyword, notice: "Verificação de ranking manual iniciada."
  end

  private
    def set_tracked_keyword
      @tracked_keyword = TrackedKeyword.find(params[:id])
    end

    def tracked_keyword_params
      params.require(:tracked_keyword).permit(:keyword, :domain, :gl, :hl)
    end
end
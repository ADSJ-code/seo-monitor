class TrackedKeyword
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :ranking_histories, dependent: :destroy
  field :keyword, type: String
  field :domain, type: String

  field :gl, type: String, default: "br"
  field :hl, type: String, default: "pt"

  field :status, type: String
  field :error_message, type: String

  validates :keyword, presence: true
  validates :domain, presence: true

  before_update :clear_history_if_changed
  after_create :queue_ranking_check
  after_update :queue_ranking_check_if_needed

  private

  def clear_history_if_changed
    if keyword_changed? || domain_changed?
      self.ranking_histories.destroy_all
    end
  end

  def queue_ranking_check
    SeoCheckWorker.perform_async(self.id.to_s)
  end

  def queue_ranking_check_if_needed
    if keyword_changed? || domain_changed?
      SeoCheckWorker.perform_async(self.id.to_s)
    end
  end
end
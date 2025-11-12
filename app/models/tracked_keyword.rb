class TrackedKeyword
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :ranking_histories
  field :keyword, type: String
  field :domain, type: String

  field :gl, type: String, default: "br"
  field :hl, type: String, default: "pt"

  validates :keyword, presence: true
  validates :domain, presence: true
end
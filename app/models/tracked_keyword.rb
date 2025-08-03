class TrackedKeyword
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :ranking_histories
  field :keyword, type: String
  field :domain, type: String
end

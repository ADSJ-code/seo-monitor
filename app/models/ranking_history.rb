class RankingHistory
  include Mongoid::Document
  include Mongoid::Timestamps
  field :position, type: Integer
  field :checked_on, type: Date
  belongs_to :tracked_keyword
end

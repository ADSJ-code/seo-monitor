# spec/models/tracked_keyword_spec.rb
require 'rails_helper'

RSpec.describe TrackedKeyword, type: :model do

  context 'validações' do
    it 'é válido com um keyword e um domain' do
      tracked_keyword = TrackedKeyword.new(keyword: "serpapi", domain: "serpapi.com")
      expect(tracked_keyword).to be_valid
    end

    it 'é inválido sem um keyword' do
      tracked_keyword = TrackedKeyword.new(domain: "serpapi.com")
      expect(tracked_keyword).to_not be_valid
    end

    it 'é inválido sem um domain' do
      tracked_keyword = TrackedKeyword.new(keyword: "serpapi")
      expect(tracked_keyword).to_not be_valid
    end
  end

  context 'associações' do
    it 'deve ter muitos ranking_histories' do
      is_expected.to have_many(:ranking_histories)
    end
  end
end
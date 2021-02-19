require 'spec_helper'

RSpec.describe RecipiesCollector::Connector, type: :interactor do
  describe 'fetch for recipies' do
    context "Data fetching" do
      let(:connector) { RecipiesCollector::Connector.new }
      it "Should raise ArgumentError if both query and ingredients are missing" do
        expect { connector.fetch }.to raise_error(ArgumentError)
      end
  
      it "Should return a Hash object if successfully quries RecipePuppy API" do
        response = connector.fetch query: 'omelet'
  
        returns_hash = response.is_a? Hash
  
        expect(returns_hash).to be_truthy
      end
    end
  end
end

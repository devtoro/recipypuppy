require 'spec_helper'

RSpec.describe RecipiesCollector::Gatherer, type: :interactor do
  context "Data gathering" do
    it "Raises ArgumentError in results_as_recipies if argment not an array" do
      gatherer = RecipiesCollector::Gatherer.new
      expect { gatherer.send(:results_as_recipies, {results: []}) }.to raise_error(ArgumentError)
    end

    it "Returns array of Recipe instance object from results_as_recipies private method" do
      gatherer = RecipiesCollector::Gatherer.new
      recipies_hash_array = [{ title: 'test', ingredients: 'sample', href: '', thumbnail: '' }]
      recipies_objects = gatherer.send(:results_as_recipies, recipies_hash_array)

      expect(recipies_objects.first.is_a?(Recipe)).to be_truthy
    end
  end
end

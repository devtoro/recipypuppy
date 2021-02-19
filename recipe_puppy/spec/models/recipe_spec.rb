# frozen_string_literal: true

require "rails_helper"

RSpec.describe Recipe, type: :model do
  context 'Validations' do
    it 'Should raise RuntimeError if invalid arguments are passed to validation method' do
      attributes = { title: 'sample', invalid_attr: 'invalid' }
      new_recipe = Recipe.new

      expect { new_recipe.send(:validate_attributes, attributes) }.to raise_error(RuntimeError)
    end

    it 'Should raise validate acceptable arguments' do
      attributes = { title: 'sample', ingredients: 'valid' }
      new_recipe = Recipe.new
      validation = new_recipe.send(:validate_attributes, attributes)
      
      expect(validation).to be_truthy
    end
  end

  context 'Sanitization' do
    it 'Should keep only acceptable attributes and remove the rest' do
      attributes = { title: 'sample', invalid: 'invalid' }
      new_recipe = Recipe.new
      sanitized_attributes = new_recipe.send(:sanitize_attributes, attributes)
      remains_one = sanitized_attributes.keys.count == 1
      remains_only_title = sanitized_attributes.keys.first == :title

      expect(remains_one).to be_truthy
      expect(remains_only_title).to be_truthy
    end
  end
end

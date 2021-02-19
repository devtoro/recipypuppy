# frozen_string_literal: true

# Class to handle recipies. 
# It does not inherit from active record as we don't need to store any data yet
# I could add additional validations,
# but for the purpose of this assignment I believe it as not necessary
class Recipe
  ACCEPTABLE_ATTRIBUTES = %w[title href ingredients thumbnail].freeze
  attr_accessor :title, :href, :ingredients, :thumbnail
  
  def initialize(**attributes)
    valid_attributes = sanitize_attributes(attributes)
    valid_attributes.each { |k, v| instance_variable_set("@#{k}", v) }
  end

  private

  def validate_attributes(attributes)
    attribute_keys = attributes.keys
    invalid_keys = attribute_keys.select { |key| ACCEPTABLE_ATTRIBUTES.index(key.to_s).nil? }
    raise(RuntimeError, "Has invalid attributes: #{invalid_keys}") if invalid_keys.present?

    true
  end

  def sanitize_attributes(attributes)
    attributes.reject { |k, v| ACCEPTABLE_ATTRIBUTES.index(k.to_s).nil? }
  end
end

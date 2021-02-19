# frozen_string_literal: true

# Interactor class for connecting to recipepuppy and query the API
class RecipiesCollector::Connector
  ENDPOINT = 'http://www.recipepuppy.com/api'
  attr_reader :connection

  def initialize
    @connection = init_connection
  end

  def fetch(ingredients: nil, query: nil, page: 1)
    qt = { p: page }
    raise(ArgumentError, 'Provide at least ingridents or a query') if ingredients.nil? && query.nil?

    qt.merge!(i: ingredients.to_s) if ingredients.present?
    qt.merge!(q: query.to_s) if query.present?
    resp = connection.get do |req|
      req.params = qt
    end

    response_as_json(resp)
  end

  def response_as_json(response)
    raise(RuntimeError, 'Could not fetch any data') unless response.status == 200

    JSON.parse(response.body)
  end
  
  private
  
  def init_connection
    Faraday.new(
      url: ENDPOINT
    )
  end
end

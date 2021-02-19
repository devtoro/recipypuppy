# frozen_string_literal: true

# Interactor for gathering recipies from recipepuppy
class RecipiesCollector::Gatherer
  include Interactor

  # Since RecipePupy API does not provide us with a per page option
  # and it returns 10 results per page, we are going to make 2 requestss and then serve
  # the total results that we need in order to server first 20 results
  def call
    @connector = RecipiesCollector::Connector.new
    results = gather_data    
    context.recipies = results_as_recipies(results)
  rescue ArgumentError => e
    context.fail!(errors: e)
  rescue RuntimeError => e
    context.fail!(errors: e)
  end
  
  private
  
  def gather_data
    # Fetch first 20 results
    search_key = query_params[:term].to_s.index(',').nil? ? :query : :ingredients
    first_ten = @connector.fetch(
      search_key => query_params[:term].to_s, page: 1
    )['results']

    second_ten = @connector.fetch(
      search_key => query_params[:term].to_s, page: 2
    )['results']
        
    first_ten + second_ten
  end
      
  def results_as_recipies(results = [])
    raise(ArgumentError, 'Results should be an array') unless results.is_a?(Array)

    results.map { |recipe_attrs| Recipe.new(**recipe_attrs) }
  end

  def query_params
    context.params.permit(
      :term
    )
  end
end

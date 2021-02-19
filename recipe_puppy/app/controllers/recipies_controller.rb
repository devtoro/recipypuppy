class RecipiesController < ApplicationController
  def index
    result = RecipiesCollector::Gatherer.call(params: params)

    if result.success?
      @recipies = result.recipies
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:error] = result.errors
      render template: "recipies/index", status: :unprocessable_entity
    end
  end
end

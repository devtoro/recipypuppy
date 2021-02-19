# frozen_string_literal: true

require "rails_helper"
require "capybara/rspec"

RSpec.describe "Movie creation procedure", type: :feature do
  it "Redirects to login if not authenticated" do
    visit "/recipies"
    within("#recipies-search") do
      fill_in "term-input", with: "eggs"
    end

    click_button "Search"

    expect(page).to have_content "eggs"
  end
end

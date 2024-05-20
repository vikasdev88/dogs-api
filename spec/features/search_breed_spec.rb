# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Search Breed", type: :system, js: true do
  context "when we are not searching for any image" do
    it "Search for valid breed" do
      visit root_path
      sleep 3
      expect(page).to have_content("Please Search for an Image.")
    end
  end

  context "when searching for valid breed name" do
    it "Search for valid breed" do
      visit root_path
      sleep 3
      fill_in "Please Enter the Breed", with: "Boxer"
      click_button "Search"
      sleep 3
      expect(page).to have_css("img")
    end
  end

  context "when searching not valid breed name" do
    it "should not return an image" do
      visit root_path
      sleep 3
      fill_in "Please Enter the Breed", with: "Boxer 1"
      click_button "Search"
      sleep 3
      expect(page).not_to have_css("img")
    end
  end

  context "when searching not valid breed name" do
    it "should return not valid image breed name" do
      visit root_path
      sleep 3
      fill_in "Please Enter the Breed", with: "Boxer 1"
      click_button "Search"
      sleep 3
      expect(page).not_to have_css("img")
      expect(page).to have_content("Breed not found (master breed does not exist)")
    end
  end
end

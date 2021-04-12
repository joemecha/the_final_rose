require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'I visit a bachelorette show page' do
    before :each do
      @bachelorette_1 = Bachelorette.create!(name: 'Rose Petale', season_number: 1, description: "The Original Problematic Premise")
      @bachelorette_2 = Bachelorette.create!(name: 'Daisy Duckas', season_number: 2, description: "Quack Quack")
      @marvin = @bachelorette_1.contestants.create!(name: 'Marvin Marlin', age: 45, hometown: "Miami, TX" )
      @woolly = @bachelorette_1.contestants.create!(name: 'Woolly Willy', age: 35, hometown: "Washington, DE" )

      visit "/bachelorettes/#{@bachelorette_1.id}"
    end

    it "then I see only that bachelorette's name, season number, season description" do

      expect(page).to have_content(@bachelorette_1.name)
      expect(page).to have_content("Season #{@bachelorette_1.season_number} - #{@bachelorette_1.description}")

      expect(page).to_not have_content(@bachelorette_2.name)
    end

    it "it also displays a link to view this bachelorette's contestants" do
      expect(page).to have_link("View #{@bachelorette_1.name}'s Contestants")

      click_link "View #{@bachelorette_1.name}'s Contestants"

      expect(current_path).to eq("/bachelorettes/#{@bachelorette_1.id}/contestants")
    end
  end
end

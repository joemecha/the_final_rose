require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe "I visit a bachelorette's contestants index page" do
    before :each do
      @bachelorette_1 = Bachelorette.create!(name: 'Rose Petale', season_number: 1, description: "The Original Problematic Premise")
      @marvin = @bachelorette_1.contestants.create!(name: 'Marvin Marlin', age: 45, hometown: "Miami, TX" )
      @woolly = @bachelorette_1.contestants.create!(name: 'Woolly Willy', age: 35, hometown: "Washington, DE" )
      
      visit "/bachelorettes/#{@bachelorette_1.id}/contestants"
    end

    describe "then I see names of that bachelorette's contestants along with the following information" do
      it "displays name, age, hometown of each contestant" do
        expect(page).to have_content("Name: #{@marvin.name}")
        expect(page).to have_content(@marvin.age)
        expect(page).to have_content(@marvin.hometown)
        expect(page).to have_content(@woolly.name)
        expect(page).to have_content(@woolly.age)
        expect(page).to have_content(@woolly.hometown)
      end
    end

    it "I can click on any contestant's name which links to that contestant's show page" do
      expect(page).to have_link("Marvin Marlin")
      expect(page).to have_link("Woolly Willy")

      click_link "Marvin Marlin"

      expect(current_path).to eq("/bachelorettes/#{@bachelorette_1.id}/contestants/#{@marvin.id}")
    end
  end
end

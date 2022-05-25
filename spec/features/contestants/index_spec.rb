require 'rails_helper'

describe 'contestants index page' do
  before do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

    ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)

    visit '/contestants'
  end

  it "lists all contestants and the names of the projects each contestant has been on" do
    within "#contestant-#{@jay.id}" do
      expect(page).to have_content("Jay McCarroll")
      expect(page).to have_content("News Chic")
      expect(page).to_not have_content("Upholstery Tuxedo")
    end
    within "#contestant-#{@gretchen.id}" do
      expect(page).to have_content("Gretchen Jones")
      expect(page).to have_content("News Chic")
      expect(page).to have_content("Upholstery Tuxedo")
      expect(page).to_not have_content("Boardfit")
    end
    within "#contestant-#{@erin.id}" do
      expect(page).to have_content("Boardfit")
      expect(page).to_not have_content("Gretchen Jones")
      expect(page).to_not have_content("News Chic")
      expect(page).to_not have_content("Upholstery Tuxedo")
    end
  end

  it "adds the project a contestant was added to when the form is filled out" do

    within "#contestant-#{@erin.id}" do
      expect(page).to_not have_content("News Chic")
    end

    visit "/projects/#{@news_chic.id}"

    fill_in "Contestant ID", with: "#{@erin.id}"
    click_button "Add Contestant to Project"

    visit '/contestants'


    within "#contestant-#{@erin.id}" do
      expect(page).to have_content("News Chic")
    end

  end

end

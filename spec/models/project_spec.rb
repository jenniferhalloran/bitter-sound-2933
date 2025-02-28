require 'rails_helper'


RSpec.describe Project, type: :model do
  before do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)
    @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)

    ContestantProject.create(contestant_id: @jay.id, project_id: @lit_fit.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @lit_fit.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @lit_fit.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
    ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)

  end

  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :material}
  end

  describe "relationships" do
    it {should belong_to :challenge}
    it {should have_many :contestant_projects}
    it {should have_many(:contestants).through(:contestant_projects)}
  end

  describe 'instance methods' do
    it "returns the challenge theme for an individual project" do
      expect(@lit_fit.project_theme).to eq("Apartment Furnishings")
      expect(@boardfit.project_theme).to eq("Recycled Material")
    end

    it "returns the number of contestants working on an individual project" do
      expect(@lit_fit.contestants_count).to eq(3)
      expect(@boardfit.contestants_count).to eq(2)
    end

    it "returns the average experience of all contestants working on an individual project" do
      expect(@lit_fit.avg_contestant_experience).to eq(11)
      expect(@boardfit.avg_contestant_experience).to eq(11.5)
    end
  end
end

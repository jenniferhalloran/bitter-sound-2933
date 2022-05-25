class ContestantProjectsController < ApplicationController

  def create
    ContestantProject.create!(contestant_id: params[:add_contestant_id], project_id: params[:id])
    redirect_to "/projects/#{params[:id]}"
  end

end

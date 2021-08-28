class ScenarioCommentsController < ApplicationController
  def create
    @scenario = Scenario.find(params[:scenario_id])
    @Scenario_comment = current_user.scenario_comments.new(scenario_comment_params)
    @Scenario_comment.scenario_id = @scenario.id
    render 'error' unless @Scenario_comment.save
    # redirect_to scenario_path(scenario)
  end

  def destroy
    @scenario = Scenario.find(params[:scenario_id])
    ScenarioComment.find_by(id: params[:id], scenario_id: params[:scenario_id]).destroy
    # redirect_to scenario_path(params[:scenario_id])
  end

  private

  def scenario_comment_params
    params.require(:scenario_comment).permit(:comment)
  end
end

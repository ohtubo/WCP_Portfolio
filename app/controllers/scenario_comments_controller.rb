class ScenarioCommentsController < ApplicationController
  def create
    @scenario = Scenario.find(params[:scenario_id])
    # ログインしているユーザーのモデル[scenario_comments]にデータ定義
    # private内で定義した関数[scenario_comment_params]の引数を渡す
    @Scenario_comment = current_user.scenario_comments.new(scenario_comment_params)
    # データ定義したモデル[scenario_comments]のカラム[scenario_id]に@scenario.id設定
    @Scenario_comment.scenario_id = @scenario.id
    # 保存が失敗した場合、エラー？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？
    unless @Scenario_comment.save
      render 'error'
    end
    # redirect_to scenario_path(scenario)
  end

  def destroy
    @scenario = Scenario.find(params[:scenario_id])
    # ？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？
    ScenarioComment.find_by(id: params[:id], scenario_id: params[:scenario_id]).destroy
  end

  private

  def scenario_comment_params
    # ？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？
    params.require(:scenario_comment).permit(:comment)
  end
end

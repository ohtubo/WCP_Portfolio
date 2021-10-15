class HomesController < ApplicationController
  def top
    # モデル[Scenario]を昇順で表示し、ページングを10項目に設定
    @scenarios = Scenario.all.order(created_at: :desc).page(params[:page]).per(10)
  end
end

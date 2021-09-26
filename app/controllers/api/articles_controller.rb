# マークダウン記法プレビューのコントローラー
class Api::ArticlesController < ApplicationController
  def preview
    # byebug
    @html = view_context.markdown(params[:content])
  end
end

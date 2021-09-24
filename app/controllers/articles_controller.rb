# マークダウン記法プレビューのコントローラー
class Api::ArticlesController < ApplicationController
  def preview
    @html = view_context.markdown(params[:content])
  end
end

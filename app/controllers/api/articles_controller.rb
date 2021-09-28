# マークダウン記法プレビューのコントローラー
class Api::ArticlesController < ApplicationController
  def preview
    # byebug
    @html = view_context.markdown(params[:content])
    # (params[:content])
  end

  private

  # def preview_params
  #   params.require(:scenario).permit(:content)
  # end

end

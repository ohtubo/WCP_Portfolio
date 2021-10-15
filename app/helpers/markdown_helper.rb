module MarkdownHelper
  # マークダウンを可能にするメソッド
  def markdown(text)
    unless @markdown
      options = {
        autolink: true,
        space_after_headers: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        tables: true,
        hard_wrap: true,
        xhtml: true,
        lax_html_blocks: true,
        strikethrough: true,
      }
      extensions = {
        autolink:           true,  # <>で囲まれてなくてもリンクを認識
        no_intra_emphasis:  true,  # 単語中の強調を認識しない
        fenced_code_blocks: true,  # フェンスのあるコードブロックを認識
        strikethrough:      true,  # ~ 2つで取り消し線
        superscript:        true,  # ^ の後ろが上付き文字
        tables:             true,  # テーブルを認識
        underline:          true,  # 斜線(* *)
        highlight:          true,  # ハイライト(== ==)
        quote:              true,  # 引用符(" ")
        footnotes:          true,  # 脚注( ^[1] )

        # (詳細は、https://github.com/vmg/redcarpet)
        xhtml: true,               # xhtml タグ出力(Render::XHTMLでは常に有効)
        lax_html_blocks: true,     # HTMLブロックの上下の空行を不要にする
        lax_spacing: true,         # HTMLブロックの空行を不要にする
        no_images: true,           # img 要素を無効化
        no_links: true,            # a 要素を無効化
        no_styles: true,           # style 要素を無効化
        safe_links_only: true,     # 安全なリンクだけ出力
        disable_indented_code_blocks: true, # 通常のマークダウンを認識しない。(行の先頭にある4つのスペースを持つテキストのコードブロックへの変換を無効化（ fencedcode_blocks: true と一緒の使用推奨))
        escape_html: true,         # HTMLタグをエスケープ。最優先され、:no_styles、:no_links、:no_images、:filter_html などは、削除ではなく、エスケープされる。
        with_toc_data: true,       # リンクの許可のため、出力HTMLのヘッダーにHTMLアンカー追加する
        prettify: true,            # prettyprintクラスを<code>google-code-prettifyタグに追加。
        link_attributes: true,     # リンクに追加する追加属性のハッシュ。
      }
      renderer = Redcarpet::Render::HTML.new(options)
      @markdown = Redcarpet::Markdown.new(renderer, extensions)
    end
    # byebug
    @markdown.render(text).html_safe
  end
end

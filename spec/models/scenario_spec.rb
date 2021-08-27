require 'rails_helper'

describe 'Scenarioモデルのテスト' do
  describe 'バリデーションのテスト' do
    #[.valid?]バリデーションが走った処理の後にエラーが残っているか
    subject { user.valid? }

    #factoriesで作成したテストデータをデータベース(テストデータベース)に突っ込む
    #テストの時に予めデータを突っ込んでおきたい
    #データは3つRDS,デベロップメントデータベース,テストデータベース
    #[!]つかない場合使用する時まで作らない、[!]
    #かける範囲
    let!(:other_user) {create(:scenario)}

    context 'titleカラム' do
      #この場だけのデータを生成
      it '空欄でないこと' do
        user = FactoryBot.build(:scenario, title:"")
        expect(user).not_to be_valid
      end
    end
  end
end

#click_link
# expect(page).to have_current_path user_path(user)


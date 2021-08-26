require 'rails_helper'

describe User do
  describe '#create' do
    #[.valid?]バリデーションが走った処理の後にエラーが残っているか
    subject { user.valid? }

    #factoriesで作成したテストデータをデータベース(テストデータベース)に突っ込む
    #テストの時に予めデータを突っ込んでおきたい
    #データは3つRDS,デベロップメントデータベース,テストデータベース
    #[!]つかない場合使用する時まで作らない、[!]
    #かける範囲
    let!(:other_user) { create(:user) }
    let(:user){build(:user)}
    let(:user_without_name){build(:user, name:"")}
    let(:user_limit_1){build(:user, name: Faker::Lorem.characters(number: 1))}
    let(:user_limit_2){build(:user, name: Faker::Lorem.characters(number: 2))}
    let(:user_limit_20){build(:user, name: Faker::Lorem.characters(number: 20))}
    let(:user_limit_21){build(:user, name: Faker::Lorem.characters(number: 21))}

    context 'nameカラム' do
      #この場だけのデータを生成
      it '空欄でないこと' do
        expect(user_without_name).not_to be_valid
      end
      it '2文字以上であること: 1文字は×' do
        expect(user_limit_1).not_to be_valid
      end
      it '2文字以上であること: 2文字は〇' do
        expect(user_limit_2).to be_valid
      end
      it '20文字以下であること: 20文字は〇' do
        expect(user_limit_20).to be_valid
      end
      it '20文字以下であること: 21文字は×' do
        expect(user_limit_21).not_to be_valid
      end
      it '一意性があること' do
        user.name = other_user.name
        is_expected.to eq false
      end
    end
  end
end
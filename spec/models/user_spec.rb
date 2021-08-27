require 'rails_helper'

describe 'Userモデルのテスト' do
  describe 'バリデーションのテスト' do
    #[.valid?]バリデーションが走った処理の後にエラーが残っているか
    subject { user.valid? }

    #factoriesで作成したテストデータをデータベース(テストデータベース)に突っ込む
    #テストの時に予めデータを突っ込んでおきたい
    #データは3つRDS,デベロップメントデータベース,テストデータベース
    #[!]つかない場合使用する時まで作らない、[!]
    #かける範囲
    let!(:other_user) { create(:user) }
    let(:user){build(:user)}
    # let(:user_without_name){build(:user, name:"")}
    let(:user_limit_1_name){build(:user, name: Faker::Lorem.characters(number: 1))}
    let(:user_limit_2_name){build(:user, name: Faker::Lorem.characters(number: 2))}
    let(:user_limit_20_name){build(:user, name: Faker::Lorem.characters(number: 20))}
    let(:user_limit_21_name){build(:user, name: Faker::Lorem.characters(number: 21))}
    let(:user_limit_150_self_introduction){build(:user, self_introduction: Faker::Lorem.characters(number: 150))}
    let(:user_limit_151_self_introduction){build(:user, self_introduction: Faker::Lorem.characters(number: 151))}

    context 'nameカラム' do
      #この場だけのデータを生成
      it '空欄でないこと' do
        user = FactoryBot.build(:user, name:"")
        expect(user).not_to be_valid
      end
      it '2文字以上であること: 1文字は×' do
        expect(user_limit_1_name).not_to be_valid
      end
      it '2文字以上であること: 2文字は〇' do
        expect(user_limit_2_name).to be_valid
      end
      it '20文字以下であること: 20文字は〇' do
        expect(user_limit_20_name).to be_valid
      end
      it '20文字以下であること: 21文字は×' do
        expect(user_limit_21_name).not_to be_valid
      end
      it '一意性があること' do
        user.name = other_user.name
        is_expected.to eq false
      end
    end

    context 'self_introductionカラム' do
      it '150文字以下であること: 150文字は〇' do
        expect(user_limit_150_self_introduction).to be_valid
      end
      it '150文字以下であること: 151文字は×' do
        expect(user_limit_151_self_introduction).not_to be_valid
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Scenarioモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:scenarios).macro).to eq :has_many
      end
    end

    context 'ScenarioCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:scenario_comments).macro).to eq :has_many
      end
    end

    context 'ScenarioFavoritesモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:scenario_favorites).macro).to eq :has_many
      end
    end
  end
end
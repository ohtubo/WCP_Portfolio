require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end
    context '表示内容の確認' do
      it 'TopTopリンクが表示される:タイトルが表示される' do
        rank_link = find_all('a')[0].native.inner_text
        expect(rank_link).to match(/TRPGにはまろう!/i)
      end
      it 'ランキングリンクが表示される: 左上から1番目のリンクが「ランキング」である' do
        rank_link = find_all('a')[1].native.inner_text
        expect(rank_link).to match(/ランキング/i)
      end
      it '新規登録リンクが表示される: 左上から2番目のリンクが「新規登録」である' do
        signup_link = find_all('a')[2].native.inner_text
        expect(signup_link).to match(/新規登録/i)
      end
      it 'ログインリンクが表示される: 左上から3番目のリンクが「ログイン」である' do
        login_link = find_all('a')[3].native.inner_text
        expect(login_link).to match(/ログイン/i)
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it 'TRPGにはまろうを押すと、トップ画面に遷移する' do
        home_link = find_all('a')[0].native.inner_text
        home_link = home_link.delete(' ')
        home_link.gsub!(/\n/, '')
        click_link home_link
        is_expected.to eq '/'
      end
      # it 'Homeを押すと、トップ画面に遷移する' do
      #   home_link = find_all('a')[1].native.inner_text
      #   home_link = home_link.delete(' ')
      #   home_link.gsub!(/\n/, '')
      #   click_link home_link
      #   is_expected.to eq '/'
      # end
      # it 'Aboutを押すと、アバウト画面に遷移する' do
      #   about_link = find_all('a')[2].native.inner_text
      #   about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      #   click_link about_link
      #   is_expected.to eq '/home/about'
      # end
      # it 'sign upを押すと、新規登録画面に遷移する' do
      #   signup_link = find_all('a')[3].native.inner_text
      #   signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      #   click_link signup_link
      #   is_expected.to eq '/users/sign_up'
      # end
      # it 'loginを押すと、ログイン画面に遷移する' do
      #   login_link = find_all('a')[4].native.inner_text
      #   login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      #   click_link login_link
      #   is_expected.to eq '/users/sign_in'
      # end
    end
  end
end

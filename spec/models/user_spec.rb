require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '9項目を適切に入力する: nickname, email, password, password_confirmation, last_name, first_name, last_kana, first_kana, birth' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nickname が空では登録できない' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'email が空では登録できない' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'email が過去の登録情報と重複する場合は登録できない' do
        @user.save
        @user2 = FactoryBot.build(:user, email: @user.email)
        @user2.valid?
        expect(@user2.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it 'email は @ を含まないと登録できない' do
        @user.email = "lorem"
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end

      it 'password が空では登録できない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'password が5文字以下では登録できない' do
        @user.password = Faker::Lorem.characters(number: 5, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it 'password が129文字以上では登録できない' do
        @user.password = Faker::Lorem.characters(number: 129, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは128文字以内で入力してください")
      end
      it 'password が英字だけでは登録できない' do
        @user.password = Faker::Lorem.characters(number: 6, min_alpha: 6)
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it 'password が数字だけでは登録できない' do
        @user.password = Faker::Number.number(digits: 6)
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it 'password と password_confirmation が不一致では登録できない' do
        @user.password = Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation = "#{@user.password}z"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'last_name が空では登録できない' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（姓）を入力してください")
      end
      it 'last_name が英字を含むと登録できない' do
        @user.last_name = "#{Faker::Name.last_name}a"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（姓）は不正な値です")
      end
      it 'last_name が数字を含むと登録できない' do
        @user.last_name = "#{Faker::Name.last_name}1"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（姓）は不正な値です")
      end

      it 'first_name が空では登録できない' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（名）を入力してください")
      end
      it 'first_name が英字を含むと登録できない' do
        @user.first_name = "#{Faker::Name.first_name}z"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（名）は不正な値です")
      end
      it 'first_name が数字を含むと登録できない' do
        @user.first_name = "#{Faker::Name.first_name}9"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（名）は不正な値です")
      end

      it 'last_kana が空では登録できない' do
        @user.last_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（姓）を入力してください")
      end
      it 'last_kana が英字を含むと登録できない' do
        @user.last_kana = "アb"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（姓）は不正な値です")
      end
      it 'last_kana が数字を含むと登録できない' do
        @user.last_kana = "ア2"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（姓）は不正な値です")
      end
      it 'last_kana がひらがなを含むと登録できない' do
        @user.last_kana = "アい"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（姓）は不正な値です")
      end
      it 'last_kana が漢字を含むと登録できない' do
        @user.last_kana = "ア伊"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（姓）は不正な値です")
      end

      it 'first_kana が空では登録できない' do
        @user.first_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（名）を入力してください")
      end
      it 'first_kana が英字を含むと登録できない' do
        @user.first_kana = "アb"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（名）は不正な値です")
      end
      it 'first_kana が数字を含むと登録できない' do
        @user.first_kana = "ア2"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（名）は不正な値です")
      end
      it 'first_kana がひらがなを含むと登録できない' do
        @user.first_kana = "アい"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（名）は不正な値です")
      end
      it 'first_kana が漢字を含むと登録できない' do
        @user.first_kana = "ア伊"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（名）は不正な値です")
      end

      it 'birth が空では登録できない' do
        @user.birth = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end

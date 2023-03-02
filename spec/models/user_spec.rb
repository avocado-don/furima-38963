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
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'email が空では登録できない' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'email が過去の登録情報と重複する場合は登録できない' do
        @user.save
        @user2 = FactoryBot.build(:user, email: @user.email)
        @user2.valid?
        expect(@user2.errors.full_messages).to include("Email has already been taken")
      end
      it 'email は @ を含まないと登録できない' do
        @user.email = "lorem"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'password が空では登録できない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'password が5文字以下では登録できない' do
        @user.password = "12345"
        @user.password_confirmation = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'password が129文字以上では登録できない' do
        @user.password = Faker::Lorem.characters(number: 129, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
      it 'password が英字だけでは登録できない' do
        @user.password = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'password が数字だけでは登録できない' do
        @user.password = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'password と password_confirmation が不一致では登録できない' do
        @user.password = "123456"
        @user.password_confirmation = "123457"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'last_name が空では登録できない' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_name が英字を含むと登録できない' do
        @user.last_name = "あb"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      it 'last_name が数字を含むと登録できない' do
        @user.last_name = "あ2"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end

      it 'first_name が空では登録できない' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_name が英字を含むと登録できない' do
        @user.first_name = "あb"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it 'first_name が数字を含むと登録できない' do
        @user.first_name = "あ2"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end

      it 'last_kana が空では登録できない' do
        @user.last_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last kana can't be blank")
      end
      it 'last_kana が英字を含むと登録できない' do
        @user.last_kana = "アb"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last kana is invalid")
      end
      it 'last_kana が数字を含むと登録できない' do
        @user.last_kana = "ア2"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last kana is invalid")
      end
      it 'last_kana がひらがなを含むと登録できない' do
        @user.last_kana = "アい"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last kana is invalid")
      end
      it 'last_kana が漢字を含むと登録できない' do
        @user.last_kana = "ア伊"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last kana is invalid")
      end

      it 'first_kana が空では登録できない' do
        @user.first_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First kana can't be blank")
      end
      it 'first_kana が英字を含むと登録できない' do
        @user.first_kana = "アb"
        @user.valid?
        expect(@user.errors.full_messages).to include("First kana is invalid")
      end
      it 'first_kana が数字を含むと登録できない' do
        @user.first_kana = "ア2"
        @user.valid?
        expect(@user.errors.full_messages).to include("First kana is invalid")
      end
      it 'first_kana がひらがなを含むと登録できない' do
        @user.first_kana = "アい"
        @user.valid?
        expect(@user.errors.full_messages).to include("First kana is invalid")
      end
      it 'first_kana が漢字を含むと登録できない' do
        @user.first_kana = "ア伊"
        @user.valid?
        expect(@user.errors.full_messages).to include("First kana is invalid")
      end

      it 'birth が空では登録できない' do
        @user.birth = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth can't be blank")
      end
    end
  end
end

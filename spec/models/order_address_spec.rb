require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    sleep 0.1 #処理が早すぎると同じテストコードでも失敗することがあるので、処理をあえて遅くすることで安定して成功させている。(記述者補足)
  end

  describe '商品購入' do
    context '商品を購入できる場合' do
      it '6項目を適切に入力する: :token, :post_code, :prefecture_id, :city, :street, :phone_num' do
        expect(@order_address).to be_valid
      end
      it 'building は空でも保存できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '商品を購入できない場合' do
      it 'token が空では保存できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'post_code が空では保存できない' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_code が数字と「-」1個を含めて7桁以下(e.g.123-456)では保存できない' do
        @order_address.post_code = "#{Faker::Number.number(digits: 3)}-#{Faker::Number.between(from: 0, to: 999)}"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code is invalid")
      end
      it 'post_code が数字と「-」1個を含めて9桁以上(e.g.123-45678)では保存できない' do
        @order_address.post_code = "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 5)}"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code is invalid")
      end
      it 'post_code は「-」の位置が半角数字3桁目より前(e.g.12-34567)だと保存できない' do
        @order_address.post_code = "#{Faker::Number.number(digits: 2)}-#{Faker::Number.number(digits: 5)}"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code is invalid")
      end
      it 'post_code は「-」の位置が半角数字4桁目より後(e.g.1234-567)だと保存できない' do
        @order_address.post_code = "#{Faker::Number.number(digits: 4)}-#{Faker::Number.number(digits: 3)}"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code is invalid")
      end
      it 'post_code が英字を含むと保存できない' do
        @order_address.post_code = "#{Faker::Alphanumeric.alphanumeric(number: 3, min_numeric: 2, min_alpha: 1)}-#{Faker::Number.number(digits: 4)}"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code is invalid")
      end
      it 'post_code が全角数字を含むと保存できない' do
        @order_address.post_code = "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 3)}４"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code is invalid")
      end
      it 'post_code がひらがなを含むと保存できない' do
        @order_address.post_code = "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 3)}し"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code is invalid")
      end
      it 'post_code がカタカナを含むと保存できない' do
        @order_address.post_code = "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 3)}シ"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code is invalid")
      end
      it 'post_code が漢字を含むと保存できない' do
        @order_address.post_code = "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 3)}四"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code is invalid")
      end

      it 'prefecture のメニュー選択が初期値「---」では保存できない' do
        @order_address.prefecture_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'city が空では保存できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'street が空では保存できない' do
        @order_address.street = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Street can't be blank")
      end

      it 'phone_num が空では保存できない' do
        @order_address.phone_num = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone num can't be blank")
      end
      it 'phone_num が数字9桁以下では保存できない' do
        @order_address.phone_num = Faker::Number.number(digits: 9)
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone num is invalid")
      end
      it 'phone_num が数字12桁以上では保存できない' do
        @order_address.phone_num = Faker::Number.number(digits: 12)
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone num is invalid")
      end
      it 'phone_num が「-」を含むと保存できない' do
        @order_address.phone_num = "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 7)}"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone num is invalid")
      end
      it 'phone_num が英字を含むと保存できない' do
        @order_address.phone_num = Faker::Alphanumeric.alphanumeric(number: 11, min_numeric: 10, min_alpha: 1)
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone num is invalid")
      end
      it 'phone_num が全角数字を含むと保存できない' do
        @order_address.phone_num = "#{Faker::Number.number(digits: 10)}５"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone num is invalid")
      end
      it 'phone_num がひらがなを含むと保存できない' do
        @order_address.phone_num = "#{Faker::Number.number(digits: 10)}ご"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone num is invalid")
      end
      it 'phone_num がカタカナを含むと保存できない' do
        @order_address.phone_num = "#{Faker::Number.number(digits: 10)}ゴ"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone num is invalid")
      end
      it 'phone_num が漢字を含むと保存できない' do
        @order_address.phone_num = "#{Faker::Number.number(digits: 10)}五"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone num is invalid")
      end

      it 'user が紐付いていないと保存できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item が紐付いていないと保存できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end

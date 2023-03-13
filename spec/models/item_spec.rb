require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品' do
    context '商品を出品できる場合' do
      it '9項目を適切に入力する: image, name, description, price, category_id, condition_id, ship_fee_id, ship_day_id, prefecture_id ' do
        expect(@item).to be_valid
      end
    end

    context '商品を出品できない場合' do
      it 'image が空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品画像を入力してください")
      end
      it 'name が空では保存できない' do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'description が空では保存できない' do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it 'category のメニュー選択が初期値「---」では保存できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
      end
      it 'condition のメニュー選択が初期値「---」では保存できない' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選択してください")
      end
      it 'ship_fee のメニュー選択が初期値「---」では保存できない' do
        @item.ship_fee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
      end
      it 'prefecture のメニュー選択が初期値「---」では保存できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
      end
      it 'ship_day のメニュー選択が初期値「---」では保存できない' do
        @item.ship_day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
      end

      it 'price が空では保存できない' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end
      it 'price が299以下では保存できない' do
        @item.price = Faker::Number.between(from: 0, to: 299)
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は300以上の値にしてください")
      end
      it 'price が10_000_000以上では保存できない' do
        @item.price = Faker::Number.between(from: 10_000_000, to: 100_000_000)
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は9999999以下の値にしてください")
      end
      it 'price が小数を含むと保存できない' do
        @item.price = Faker::Number.decimal(l_digits: 4)
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は整数で入力してください")
      end
      it 'price が英字を含むと保存できない' do
        @item.price = Faker::Alphanumeric.alphanumeric(number: 4, min_numeric: 3, min_alpha: 1)
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください")
      end
      it 'price が全角数字を含むと保存できない' do
        @item.price = "#{Faker::Number.number(digits: 3)}０"
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください")
      end
      it 'price がひらがなを含むと保存できない' do
        @item.price = "#{Faker::Number.number(digits: 3)}れ"
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください")
      end
      it 'price がカタカナを含むと保存できない' do
        @item.price = "#{Faker::Number.number(digits: 3)}レ"
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください")
      end
      it 'price が漢字を含むと保存できない' do
        @item.price = "#{Faker::Number.number(digits: 3)}零"
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください")
      end

      it 'user が紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end

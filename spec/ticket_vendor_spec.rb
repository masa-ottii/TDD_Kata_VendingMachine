require_relative '../ticket_vendor'

RSpec.describe 'TicketVendor' do
  let(:vendor){ TicketVendor.new }
  context 'step1' do
    it 'お金を一枚ずつ投入できる、そして投入したお金は投入金額に加算されている' do
        vendor.insert(10)
        vendor.insert(50)
        vendor.insert(100)
        vendor.insert(500)
        vendor.insert(1000)
        expect(vendor.inserted_money).to eq (1660)
    end
    it '利用できないお金を投入したら、そのまま返却し、投入金額に加算されない' do
        expect(vendor.insert(1)).to eq(1)
        expect(vendor.insert(5)).to eq(5)
        expect(vendor.insert(10000)).to eq(10000)
        expect(vendor.insert(-1)).to eq(-1)
        expect(vendor.inserted_money).to eq(0)
    end
  end
  context 'step2' do
    it 'おつりの返金を行うと、その時点での投入金額分のお金が返される。' do
      vendor.insert(100)
      vendor.insert(100)
      vendor.insert(100)
      expect(vendor.refund).to eq(300)
    end
    it 'おつりの返金を行うと、投入金額は0になっている' do
      vendor.insert(1000)
      r = vendor.refund
      expect(r).to eq(1000)
      expect(vendor.inserted_money).to eq(0)
    end
  end
  context 'step3' do
    it 'チケット名を指定して購入する。投入金額が足りる場合はチケットの情報が手に入る' do
      vendor.insert(50)
      vendor.insert(100)
      vendor.insert(100)
      ticket = vendor.purchase('Aチケット')

      expect(ticket[:name]).to eq('Aチケット')
      expect(vendor.inserted_money).to eq(0)
    end
    it 'チケット名を指定して購入する。該当するチケットがない場合はnilが返される' do
      vendor.insert(50)
      vendor.insert(100)
      vendor.insert(100)
      ticket = vendor.purchase('存在しないチケット')

      expect(ticket).to eq nil
      expect(vendor.inserted_money).to eq(250)
    end
    it 'チケット名を指定して購入する。投入金額が足りない場合はnilが返される' do
      vendor.insert(50)
      ticket = vendor.purchase('Aチケット')

      expect(ticket).to eq nil
      expect(vendor.inserted_money).to eq(50)
    end
    it '多めにお金を入れてチケットを購入すると、投入金額にはあまりのお金が残っている' do
      vendor.insert(1000)
      ticket = vendor.purchase('Aチケット')

      expect(ticket[:name]).to eq('Aチケット')
      expect(vendor.inserted_money).to eq(750)
    end
  end
end

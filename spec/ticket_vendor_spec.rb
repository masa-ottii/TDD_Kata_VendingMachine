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

  end
  context 'step3' do

  end
end

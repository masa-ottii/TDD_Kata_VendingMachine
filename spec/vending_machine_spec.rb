require_relative '../vending_machine'

describe VendingMachine do

  before do
    @vm = VendingMachine.new
  end

 context 'STEP0' do
    it 'insert coin and add to total' do
        @vm.insert(10)
        @vm.insert(50)
        @vm.insert(100)
        @vm.insert(500)
        @vm.insert(1000)
        total_coin = @vm.inserted_coin
        expect(total_coin).to eq (1660)
    end

    it 'refunds total coin' do
        @vm.insert(100)
        @vm.insert(100)
        total_coin = @vm.inserted_coin
        refunds_coin = @vm.refund
        expect(refunds_coin).to eq (total_coin)
    end
  end
  context 'STEP1' do
    it 'check available coin by sub method' do
        expect(@vm.available_coin?(10)).to be true
        expect(@vm.available_coin?(50)).to be true
        expect(@vm.available_coin?(100)).to be true
        expect(@vm.available_coin?(500)).to be true
        expect(@vm.available_coin?(1000)).to be true

        expect(@vm.available_coin?(10000)).to be false
        expect(@vm.available_coin?(1)).to be false
        expect(@vm.available_coin?(5)).to be false
        expect(@vm.available_coin?(-1)).to be false
    end
    it 'return insert coin when use unavailable coin and total money unchange' do
        expect(@vm.insert(10)).to eq nil
        expect(@vm.insert(50)).to eq nil
        expect(@vm.insert(100)).to eq nil
        expect(@vm.insert(500)).to eq nil
        expect(@vm.insert(1000)).to eq nil
        expect(@vm.inserted_coin).to eq 1660

        expect(@vm.insert(10000)).to eq 10000
        expect(@vm.insert(1)).to eq 1
        expect(@vm.insert(5)).to eq 5
        expect(@vm.insert(-1)).to eq(-1)
        expect(@vm.inserted_coin).to eq 1660
    end
  end
  context 'STEP2' do
    it 'set juice drink and get stock drink list' do
      d = {:price=>150,:name=>'coffee'}
      @vm.set_item(d)
      e = {:price=>200,:name=>'mets'}
      @vm.set_item(e)
      expect(@vm.stocks).to eq [
        {:price=>120,:name=>'cola'},
        {:price=>120,:name=>'cola'},
        {:price=>120,:name=>'cola'},
        {:price=>120,:name=>'cola'},
        {:price=>120,:name=>'cola'},
        {:price=>150,:name=>'coffee'},
        {:price=>200,:name=>'mets'}
      ]
    end
  end
  context 'STEP3' do
    it 'purchase Cola then put out from stock ' do
      @vm.insert(120)
      drink = @vm.purchase('cola')
      if drink != nil
        expect(@vm.stocks).to eq [
          {:price=>120,:name=>'cola'},
          {:price=>120,:name=>'cola'},
          {:price=>120,:name=>'cola'},
          {:price=>120,:name=>'cola'}
        ]
        expect(@vm.sales).to eq (120)
        expect(@vm.refund).to eq (90)
      end
    end
    it 'purchase Cola but short of money' do
      @vm.insert(100)
      drink = @vm.purchase('cola')
      expect(drink).to be_nil
      expect(@vm.refund).to eq (100)
    end
  end
end

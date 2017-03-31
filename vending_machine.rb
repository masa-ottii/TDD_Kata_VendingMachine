
class VendingMachine
  def initialize
    @available_coin = [10,50,100,500,1000]
    @total_coin = 0
    @stocks = [
      {:price=>120,:name=>'cola'},
      {:price=>120,:name=>'cola'},
      {:price=>120,:name=>'cola'},
      {:price=>120,:name=>'cola'},
      {:price=>120,:name=>'cola'}
    ]
    @sale = 0
  end
  def set_item(item)
    @stocks << item
  end
  def insert(coin)
    if available_coin?(coin)
      @total_coin += coin
      return nil
    else
      return coin
    end
  end
  def purchase(item_name)
    purchase_item = @stocks.delete_at(@stocks.index({:price=>0,:name=>item_name}))
    @sale += purchase_item.price
    return purchase_item
  end
  def total
    @total_coin
  end
  def stocks
    @stocks
  end
  def sales
    @sale
  end
  def refund
    @total_coin.tap{ |t| t = 0 }
  end
  def available_coin?(coin)
    @available_coin.include?(coin)
  end
end


class VendingMachine
  def initialize
    @available_coin = [10,50,100,500,1000]
    @inserted_coin = 0
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
      @inserted_coin += coin
      return nil
    else
      return coin
    end
  end
  def purchase(item_name)
    purchase_item = @stocks.delete_at(@stocks.index { |item| item[:name] == item_name })
    if purchase_item[:price] < inserted_coin
      @sale += purchase_item[:price]
      @inserted_coin -= purchase_item[:price]
      return purchase_item
    else
      return nil
    end
  end
  def inserted_coin
    @inserted_coin
  end
  def stocks
    @stocks
  end
  def sales
    @sale
  end
  def refund
    @inserted_coin.tap{ |t| t = 0 }
  end
  def available_coin?(coin)
    @available_coin.include?(coin)
  end
end

class TicketVendor
  def initialize
    @available_money = [10,50,100,500,1000]
    @money = 0;
  end
  def insert(money)
    if @available_money.include?(money)
      @money += money
    else
      money
    end
  end
  def inserted_money
    @money
  end
end

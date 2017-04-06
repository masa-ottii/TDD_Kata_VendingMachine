#
# チケット自動販売機クラス
#
class TicketVendor
  # 初期化用メソッド（コンストラクタ）
  def initialize
    # 利用できるお金の種類
    @available_money = [10,50,100,500,1000]
    # 在庫として持っているチケット
    @stocks = [
      {:name=>'Aチケット',:price=>250},
      {:name=>'Bチケット',:price=>360},
      {:name=>'Cチケット',:price=>520}
    ]
    # 投入されたお金
    @money = 0;
  end

  # 販売機にお金を投入する
  # 引数　：　(投入するお金 : String)
  # 戻り値：　取り扱えるお金(10円,50円,100円,500円,1000円)ならnil
  #         取扱のないお金ならそのお金:Integer
  def insert(money)
    # 投入されたお金が、利用できるお金の種類か否かを判定する
    if @available_money.include?(money)
      @money += money
      return nil
    else
      money
    end
  end

  # 投入されたお金の総額を返す
  # 引数　：　なし
  # 戻り値：　投入されたお金の総額:Integer
  def inserted_money
    @money
  end

  # チケットを購入する
  # 引数　：　(購入するチケットの名前:String)
  # 戻り値：  購入したチケットの情報:Hash
  #         投入金額が足りない or 存在しないチケットを指定された の場合はnil
  def purchase(ticket_name)
    ticket = nil
    # ストック内からチケットの名称で検索
    correspond = @stocks.index { |element| element[:name] == ticket_name }
    # 該当するチケットがストック内にある場合
    unless correspond == nil
      # 該当のチケットの情報を得る
      ticket = @stocks[correspond]
      # 投入金額がチケットを買うのに十分な場合
      if @money >= ticket[:price]
        # チケット代を投入金額から差し引く
        @money -= ticket[:price]
      else
        # 投入金額が足りない場合はnilを返す
        ticket = nil
      end
    end
    return ticket
  end

  # おつりを返金する。返金後は投入金額は0になる
  # 引数　：　なし
  # 戻り値：  現時点の投入金額:Integer
  def refund
    # tapを使ってブロックが実行される前の値（投入金額）を返す
    # ブロック内で投入金額を0にしている
    @money.tap { @money = 0 }
  end
end

# チケット自動販売機

## 外部設計（機能設計）

### ステップ1　お金の投入と利用できないお金の判定
* 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ「投入」できる。
* 「投入」は複数回できる。
* 「投入金額の総計を取得」できる。
* 想定外のもの（硬貨：１円玉、５円玉。お札：千円札以外のお札）が「投入」された場合は、投入金額に加算せず、それはそのままユーザーに返す。

### ステップ２　おつり

* 「おつりの返金」を行うと、その時点での投入金額分のお金が返される。
* 「おつりの返金」を行うと、投入金額は0になる。
* おつりとして返すお金の種類は考慮しなくても良い。また硬貨やお札の在庫は無限にあると考えて良い。


### ステップ３　チケットの購入

* 値段と名前からなるチケットをあらかじめ設定する。
* 初期状態で、Aチケット（値段:250円）、Bチケット（値段:360円）、Cチケット（値段:520円）の三種類が設定されているものとする。
* 「購入」はチケット名を指定して購入する。
* 「購入」は何度でもできる。
* 「購入」しようとすると、それまでの投入金額から、チケットが購入できるかどうかを判断する。
* チケットが十分購入できる金額を投入した状態で、「購入」を行うとチケット（のデータ）が返される。
* 投入金額が足りない場合は、「購入」を行っても何もしない。
* 投入金額は、購入した額に合わせて減らされる。


## 内部設計（クラス設計・メソッド設計）

* クラス名:TicketVendor
* ファイル名: ticket_vendor.rb

| 所属するメソッド | 説明 |
|:----------------------------:|:-----------:|
| initialize |
| 初期化用メソッド（コンストラクタ）|
| insert |
| 販売機にお金を投入するメソッド   |
| 引数　|　投入するお金 : Integer型 |
| 戻り値 |　取り扱えるお金(10円,50円,100円,500円,1000円)ならnil。取扱のないお金ならそのお金:Integer |
| inserted_money |
| 投入されたお金の総額を返すメソッド |
| 引数 | なし |
| 戻り値 | 投入されたお金の総額:Integer型 |
|  purchase |
| チケットを購入するメソッド |
| 引数　|　購入するチケットの名前:String型 |
| 戻り値 |  購入したチケットの情報:Hash型、投入金額が足りないor存在しないチケットを指定された場合はnil |
| refund |
| おつりを返金するメソッド 返金後は投入金額は0になる |
| 引数　|　なし |
| 戻り値 |  現時点の投入金額:Integer型 |

* チケット情報の持ち方（実装例）

```
@stocks = [
  {:name=>'Aチケット',:price=>250},
  {:name=>'Bチケット',:price=>360},
  {:name=>'Cチケット',:price=>520}
]
```

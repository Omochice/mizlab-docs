---
layout: default
title: 電子情報工学演習B 第4回
parent: 電子情報工学演習B
---

# {{ page.title }}


## 課題

> SwissProt データベース(uniprot_sprot.fasta) 中の各アミノ酸の出現頻度（絶対数およびパーセント値）を求め、出現頻度の降順にソートしてアミノ酸の3文字コード、1文字コードと合わせてリストを作成しなさい。


## 方針

- データベース中の各エントリに出現するアミノ酸の絶対数を算出
- 全エントリの合計を算出
- ハッシュの中身をソートし、配列を得る
- リストを出力する
    - エクセルを別途開くのが面倒なので筆者は TSV 形式でデータを出力しました。

## 使えそうなメソッド

* [`Hash.merge!`](https://docs.ruby-lang.org/ja/latest/class/Hash.html#I_MERGE)
    `Hash` と `Hash` をマージする。
    ```ruby
    foo = { a: 10, b: 20 }
    bar = { b: 30, c: 40 }
    foo.merge!(bar) { |key, foo_value, bar_value| foo_value + bar_value }
    p foo
    # => {a: 10, b: 50, c: 40}
    ```
* [`Bio::Sequence::AA.codes`](http://bioruby.org/rdoc/Bio/Sequence/AA.html#method-i-codes)
    アミノ酸の 1 文字コードを 3 文字コードに変換する。
    ```ruby
    require "bio"

    seq = Bio::Sequence::AA.new("RRLE")
    p s.codes
    # => ["Arg", "Arg", "Leu", "Glu"]
    ```
* [文字列中での式の展開](https://docs.ruby-lang.org/ja/latest/doc/spec=2fliteral.html#exp)
    ```ruby
    number = 0.01
    str = "The number is #{number}, It means #{number * 100}%."
    p str
    # => The number is 1, It means 1.0%
    ```

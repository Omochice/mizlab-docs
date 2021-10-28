---
layout: post
title: 電子情報工学演習B 第6回
parent: 電子情報工学演習B
author: まつもと
posted_at: 2021-10-15
---

# {{ page.title }}

## 課題

> 次の各ゲノムについて GC skew $$(=\frac{C-G}{C+G})$$ を求めよ

## 使えそうなもの

- グラフ画像生成ツール
    生物ごとに gnuplot の設定ファイルの生成をするのが面倒であれば `numo-gnuplot` や `GR.rb` などの Ruby からグラフ画像生成をするライブラリを使用するのも良いでしょう。
    ライブラリを使わなくても設定ファイルを Ruby プログラム内で生成して [`system`](https://docs.ruby-lang.org/ja/latest/method/Kernel/m/system.html) などを使って `gnuplot` を実行することもできます。

- 配列の累積和の算出 
    Ruby では他の言語に比べて[モンキーパッチ](https://ja.wikipedia.org/wiki/%E3%83%A2%E3%83%B3%E3%82%AD%E3%83%BC%E3%83%91%E3%83%83%E3%83%81)をするのが簡単です。
    単独の関数として `accumulate` を実装することもできますが、既存の `Array` クラスを拡張することもできます。

    ```ruby
    arr = [1, 2, 3]
    p arr.accumulate # この時点ではArrayクラスにaccumulateメソッドは存在しない

    class Array
      def accumulate
        sum = 0
        accumulated = []
        self.each do |content|
          sum += content
          accumulated.append(sum)
        end
        return accumulated
      end
    end

    p arr.accumulate
    # => [1, 3, 6]
    ```

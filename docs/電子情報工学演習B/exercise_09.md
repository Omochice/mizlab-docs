---
layout: post
title: 電子情報工学演習B 第9回
parent: 電子情報工学演習B
author: まつもと
posted_at: 2021-12-25
---

# {{ page.title }}

## 課題

> 大腸菌2種 (K12、O157) について、ゲノム配列中の長さ8の語とその相補語の出現頻度の相関を調べる。
> - 相補語：塩基を相補的な塩基（A⇔T、G⇔C）に置き換えて、順序を逆にした語。
> - 相補語は、語 `w` に対してメソッド `complement` を適用して `w.complement` によって得られる。

## ヒント

流れは以下のようになるでしょう。

1. 語の出現頻度を計測する。
    
    前回までの方法と同様にできるはずです。

2. プロットするためにデータを整形する。

    
## 使えそうなもの

- `Bio::Sequence::NA.complement`
    
    [`Bio::Sequence::NA.reverse_complement`](http://bioruby.org/rdoc/Bio/Sequence/NA.html#method-i-reverse_complement)のエイリアスです。

    ```ruby
    require "bio"

    s = Bio::Sequence::NA.new("atgc")
    puts s.reverse_complement  # => "gcat"
    ```

- 相関係数
    
    ピアソンの相関係数は以下の式で求められます。

    $$
    r_{xy} = \frac{\displaystyle \sum_{i = 1}^n (x_i - \overline{x})
    (y_i - \overline{y})}{\sqrt{\displaystyle \sum_{i = 1}^n 
    (x_i - \overline{x})^2}\sqrt{\displaystyle \sum_{i = 1}^n 
    (y_i - \overline{y})^2}}
    $$

    これを Ruby で書くと次のようになるでしょう。
    
    ```ruby
    def correlation_coefficient(x, y)
      x_average = x.sum / x.length.to_f
      y_average = y.sum / y.length.to_f
      cov = x.zip(y).map { |xi, yi| (xi - x_average) * (yi - y_average) }.sum
      x_rho = x.map { |xi| (xi - x_average) ** 2 }.sum
      y_rho = y.map { |yi| (yi - y_average) ** 2 }.sum
      return cov / (x_rho ** 0.5 * y_rho ** 0.5)
    end
    ```



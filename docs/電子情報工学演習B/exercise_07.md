---
layout: post
title: 電子情報工学演習B 第7回
parent: 電子情報工学演習B
author: まつもと
posted_at: 2021-11-12
---

# {{ page.title }}

## 課題

> A, T, G, Cの4文字から作られる長さ8の文字列（語）に対して，大腸菌K12（U00096）、大腸菌O157（AE005174）、ペスト菌（AL590842）のそれぞれのゲノム配列中の出現頻度（回数）を計測し、出現頻度分布を比較する。

## ヒント

- 既知の文字列が配列中にいくつあるかを数える
    
    `abcdabcd` という文字列に `ab` という部分文字列がいくつ含まれるかを調べるには、以下が使えます。

    ```ruby
    "abcdabcd".scan("ab").length
    ```

    このメソッドは文字列を走査するので、文字列の長さを $$n$$ としたときの時間計算量は $$\mathrm{O}(n)$$ となります。
    今回の課題の場合、`AAAAAAAA` ~ `CCCCCCCC` までの $$4^8$$ 個の部分文字列を検索すると $$\mathrm{O}(n)$$ の処理を $$4^8$$ 回することになり、かなりの時間がかかります。
    そのため、`window_search` を使い、切り出された 8 文字をキーとして持つハッシュを作成してから、各文字列に対して処理をすると良いでしょう。(これだと $$\mathrm{O}(n)$$ で済む)

## 使えそうなもの

- `window_search`

    Ruby のバージョンが `3` であり、かつ `bio` のバージョンが `2.0.3` 未満の場合、 `window_search` の返り値のクラスが `String` になります。
    `2.0.3` で修正されたため、この問題が起こった場合は `gem update bio` アップデートしてください。


- `Numo-gnuplot`
    
    Ruby で gnuplot を扱うライブラリに `numo-gnuplot` があります。
    gnuplot の書式をほぼそのまま使えるため、Ruby 単体で分析処理を完結させたい場合は選択肢になるでしょう。
    以下に $$\sin$$ 関数のグラフを gnuplot, `numo-gnuplot` それぞれで書く場合のコードを掲載します。

    - `gnuplot`

        ```sh
        set nokey
        set title "the title"
        set xlabel "x"
        set ylabel "y"
        set terminal pdf enhanced color size 4in,3in
        set output "test.pdf"
        plot [-pi:pi] sin(x) with line
        ```

    - `Ruby`

        ```ruby
        require "numo/gnuplot"

        x = []
        y = []

        x_current = -Math::PI
        dx = 0
        while x_current <= Math::PI
          x_current += dx
          x << x_current
          y << Math.sin(x_current)
          dx += 0.01
        end

        Numo.gnuplot do
          set(:nokey)
          set({ :title => "the title" })
          set({ :xlabel => "x" })
          set({ :ylabel => "y" })
          set({ :terminal => { :pdf => { :enhanced => "color", :size => "4in,3in" } } })
          set({ :output => "test.pdf" })
          plot(x, y, { :with => "line" })
        end
        ```

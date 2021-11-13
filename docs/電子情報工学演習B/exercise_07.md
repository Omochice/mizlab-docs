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
    
    `abcdabcd` という文字列に `ab` という文字がいくつ含まれるかを調べるには、以下が使えます。

    ```ruby
    "abcdabcd".scan("ab").length
    ```

    このメソッドは文字列を走査するので、文字列の長さを $$n$$ としたときの時間計算量は $$\mathrm{O}(n)$$ となります。
    今回の課題の場合、`AAAA` ~ `CCCC` までの 256 通り全てに対して $$\mathrm{O}(n)$$ の処理をすると時間がかかります。
    そのため、`window_search` を使い、ハッシュを作成すると良いでしょう。(これだと$$\mathrm{O}(n)$$で済む)

## 使えそうなもの

- `window_search`

    Bioruby のドキュメントでは `Bio::Sequence` が返ってくると書いていますが、`String` が返ってくるので注意。(おそらく Ruby のバージョン更新による変更)
    確認した環境は以下の通り。

    ```sh
    $ ruby --version
    ruby 3.0.1p64 (2021-04-05 revision 0fb782ee38) [x86_64-linux]

    $ gem list | grep bio
    bio (2.0.2)
    ```
    
    ```ruby
    require "bio"
    
    dna = Bio::Sequence.new("atgcatgc")
    dna.widnow_search(3, 1) do |codon|
        p codon.class # => String
    end
    ```

- `Numo-gnuplot`
    
    Ruby で gnuplot を扱うライブラリに `numo-gnuplot` があります。
    ghuplot の書式をほぼそのまま使えるため、Ruby 単体で分析処理を完結させたい場合は選択肢になるでしょう。
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

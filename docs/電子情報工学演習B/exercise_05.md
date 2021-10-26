---
layout: default
title: 電子情報工学演習B 第5回
parent: 電子情報工学演習B
---

# 電子情報工学演習B 第5回

## 課題

> **GC 含量の解析**  
> ウイルス由来の DNA 配列の GC 含量の分布を調べる。

### 使えそうな知識

- `less`
    ```console
    $ less ddbjvrl01.seq
    ```
    vim コマンドで操作します。矢印キーも使えます。
    知っておくとよさそうなものを抜粋すると
    |キー|動作|
    |---|---|
    |/\<word\>|`word` を検索|
    |n|検索した文字列の次のマッチへ移動|
    |N|検索した文字列の前のマッチへ移動|
    |gg|ファイルの先頭に移動|
    |G|ファイルの末尾へ移動|
    |q|終了|

    詳しくはこちらへ

    - [【 less 】コマンド（基本編）](https://atmarkit.itmedia.co.jp/ait/articles/1702/09/news031.html)
    - [あなたはだんだん、ファイルを読むのにlessコマンドを使いたくなる](https://qiita.com/marrontan619/items/95e954972706f32be255)

- GC 含量
    塩基配列の GC 含量は gc_percent メソッドで得られます。
    ```ruby
    bioruby> dna = getseq("atgcatgcaaaa")
    bioruby> p dna.gc_percent
    # => 33
    ```

- gnuplot
    - [ruby の gnuplot ラッパー](https://github.com/ruby-numo/numo-gnuplot)もありますが、ここでは割愛します。興味があればぜひどうぞ。
    ```txt
    # "GC contents (%)" "Frequency"
    5 8
    10 12
    15 13
    .
    .
    .
    85 12
    90 9
    95 7
    100 6
    ```
    ```gpt
    set nokey
    set ylabel "Freqency"
    set xlabel "GC Contents (%)"
    set style fill solid 0.5
    set term pdfcairo color size 4in, 3in # カラー
    set output "histogram.pdf"
    plot [0:100] "hist.dat" using ($1-2.5):2 with boxes
    ```
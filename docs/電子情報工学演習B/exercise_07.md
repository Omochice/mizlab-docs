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

## 使えそうなもの

- `window_search`

    `Bio::Sequence` なオブジェクトに対して `window_search` をすると `String` が返ってきます。
    Bioruby のドキュメントでは `Bio::Sequence` が返ってくるように書いているので注意。(おそらく Ruby のバージョン更新による変更)
    
    ```ruby
    require "bio"
    
    dna = Bio::Sequence.new("atgcatgc")
    dna.widnow_search(3, 1) do |codon|
        p codon.class # => String
    end
    ```



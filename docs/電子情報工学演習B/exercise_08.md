---
layout: post
title: 電子情報工学演習B 第8回
parent: 電子情報工学演習B
author: まつもと
posted_at: 2021-12-25
---

# {{ page.title }}

## 課題

> 「語の出現頻度の計測 (1)」と同様の計測を、無作為に選んだ長さ10の100個の語（重複なし）に対して行い、グラフを作成する。

## ヒント

プログラムが再利用可能な設計になっていれば語を差し替えるだけで動くようになります。

`word_length`の長さを持つ語を`n_words`個持つ配列を生成する関数を以下に記載します。

    ```ruby
    def get_random_word(word_length, n_words)
      base = ["a", "t", "g", "c"]
      words = []
      while words.length < 100 do 
        word = ""
        10.times do 
          word += base.sample
        end
        words << word unless words.include?(word)
      end
      return words
    end
    ```

---
layout: default
parent: 電子情報工学演習B
title: 演習の前に
---

# 演習で使えそうなこと

## テンプレ

- Ruby でコマンドライン引数をとるときは `ARGV[0]` .
- fasta 形式のファイルには複数種のデータが格納されているので,`each_entry` で処理する.

    ```ruby
    # "program.rb"
    require "bio"

    File.open(ARGV[0], "r") do |file| # "r" => read, "w" => write
        Bio::FlatFile.auto(file).each_entry do |entry|
        # ここに処理を書く
        end
    end
    ```

- コマンドライン引数でファイル名を渡す.
- `ruby` を先頭につけて実行するなら[シバン](https://ja.wikipedia.org/wiki/%E3%82%B7%E3%83%90%E3%83%B3_(Unix))を書く必要はない.

    ```console
    $ ruby program.rb uniprot.fasta
    ```

## おすすめのgem

- `ricecream`
    変数の値を変数名と一緒に表示してくれるので,デバッグが便利になる
    詳しい使い方は[こちら](https://qiita.com/nodai2h_ITC/items/6242046d789b0bf1b4de)
    ```ruby
    require 'ricecream'

    foo = 123
    p foo  # => 123
    ri foo # => ic| foo: 123
    ```

## そのほか

思いついたら随時更新します.

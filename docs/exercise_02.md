---
layout: default
title: 電子情報工学演習B 第2回
---

# {{ page.title }}

## 課題

> **BioRubyのインストール**

2回目の課題はBioRubyのインストール作業です。

研究室の共用サーバにSSHで接続して作業する場合は（おそらく）すでにインストールされたものが使用可能となっているため、この作業は必要ないでしょう。

自分のPCにBioRubyをインストールする際に留意するべき点をまとめます。


- ### rubygemのインストール
    演習ページでは、
    > synapticでrubygemをインストールする。

   となっていますが、筆者の手元のUbuntu 20.04LTSではRubyのインストール時に依存パッケージとしてrubygemがインストールされるため、この作業は不要でしょう。

- ### [BioRuby](https://github.com/bioruby/bioruby)のインストール
    執筆時点でリンク先のGitHubのリポジトリに記載されている内容の（ほぼ）転載になります。
    - インストール
        ```sh
        $ sudo gem install bio
        ```
        systemにインストールされたRubyを使っている場合（`sudo apt install ruby` などでインストールするとsystemにインストールされます）、`gem` を実行する際に `sudo` が必要です。
    - `seqdatabase.ini` の移動
        移動先は `/etc/bioinformatics/` か `~/.bioinformatics/` のどちらかです。
        ```sh
        $ mkdir ~/.bioinformatics
        $ cp /var/lib/gems/x.x.x/gems/bio-x.x.x/etc/bioinformatics/seqdatabase.ini ~/.bioinformatics/
        ```
        `x.x.x` はインストールされているRubyやbiorudyのバージョンによって変動します。

- ### [bio-shell](https://rubygems.org/gems/bio-shell)のインストール

   Biorubyのとき同様、`sudo` が必要です。

- ### ruby-bioのインストール

    筆者の環境では必要ありませんでした。


- ### `bioruby` の実行
    
    今回扱う遺伝子は11個あり、それぞれに対して `definition` などを実行するのは面倒です。
    そのため、`each` を使ってループ処理すると良いでしょう。
    また、データは表形式にする必要があるので、`TSV` 形式で書き出すとあとの処理が楽になるでしょう。（本来は `CSV` で吐き出すべきですが、データ文字列中に `,` が存在するのでやむなく `TSV` にしています）



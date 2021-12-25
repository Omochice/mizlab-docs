---
layout: post
title: 電子情報工学演習B 第10回
parent: 電子情報工学演習B
author: まつもと
posted_at: 2021-12-25
---

# {{ page.title }}

## 課題

> BLAST+を用いた相同タンパク質の検索

## ヒント

今回はコマンドラインで動くツールを使った課題なので、`ruby`を使わなくてもできます。

（というより `bioruby` に `blastp` を実行するクラス等が調べた限りでは存在しないようです。）

`ruby`で完結させたい人向けに、[MizLab/Mizlab-ruby](https://github.com/MizLab/Mizlab-ruby)で `blastp` と同等の処理をする方法を以下に示します。

- DB ファイルの作成

    コマンドラインで `makeblastdb` を実行することでそのファイルと同じ階層に blast 用のファイルが生成されるようです。
    `ruby`のプログラム中でシェルコマンドを実行するには[`open3`](https://docs.ruby-lang.org/ja/latest/class/Open3.html)が使えます。
    (ただ、今回の場合は素直にシェルで実行したほうがいいかもしれません。)

    ```ruby
    require "open3"
    
    def execute_command(cmd, stdin=[""])
      stdout, stderr, status = Open3.capture3(cmd.join(" "), stdin_data: stdin)
      raise IOError, stderr unless status == 0
      return [stdout, stderr]
    end

    p execute_command(["date", "-u", '+"%Y-%m-%dT%H:%M:%SZ"'])
    # => ["2021-12-25T15:02:51Z\n", ""]
    ```

- `blastp`の実行
    
    `Mizlab`モジュールには `blast` をローカル環境で実行するためのクラス `Mizlab::Blast` があります。
    これを使うことで `blast` の結果を[`Bio::Blast::Report`](http://bioruby.org/rdoc/Bio/Blast/Report.html)として得られます。

    ```ruby
    require "bio"
    require "mizlab"

    # execute blast+
    factory = Mizlab::Blast.local("blastp", "PATH TO `uniprot_sprot.fasta`")
    factory.query(seq, { "-num_alignments" => 5, "-num_descriptions" => 5 }).each do |hit|
      p hit.definition
      # => "sp|P78426|NKX61_HUMAN Homeobox protein Nkx-6.1 OS=Homo sapiens OX=9606 GN=NKX6-1 PE=1 SV=2"
      p hit.accession
      # => "275746" # パースがうまくできていないみたい(fastaの形式が良くない？)
      splited = hit.definition.split("|")
      hit.accession = splited[1]
      p hit.accession
      # => "P78426" # 無理やり置き換える
      end
    end
    ```
    


---
layout: post
title: 研究室用gemの使い方
author: まつもと
posted_at: 2021-10-28
---

# {{ page.title }}

_v0.1.6 時点での解説です。_

研究室用でよく使われるであろう作業を簡単に扱う gem を作成したので、以下に使い方をまとめます。

## インストールの仕方

システムの Ruby にインストールするには、以下を実行します。

```sh
$ gem install mizlab
```

プロジェクトのパッケージ管理に `bundle` などを使っている場合はそちらに合わせてください。

## 収録されている関数

- `getent`
    GenBank からエントリを文字列として取得します。
    ```ruby
    require "mizlab"

    # 1件だけの取得
    obj = Mizlab.getent("NC_012920")
    p obj.class # => String
    
    # 複数取得の場合はブロックを渡してください
    Mizlab.getent(["NC_012920", "NC_005089"]) do |obj|
      p obj.class # => String
    end
    ```
    
- `getobj`
    GenBank からエントリを取得し、 `Bio::GenBank` クラスのオブジェクトとして返します。
    ```ruby
    require "mizlab"

    # 1件だけの取得
    obj = Mizlab.getobj("NC_012920")
    p obj.accession # => "NC_012920"
    
    # 複数取得の場合はブロックを渡してください
    Mizlab.getobj(["NC_012920", "NC_005089"]) do |obj|
      p obj.accession # => "NC_012920", "NC_005089"
    end
    ```

- `savefile`
    `Bio::GenBank` クラスなどのオブジェクトをファイルに書き出します。
    すでに存在するファイルに書き出そうとすると上書きするかどうかの確認をします。
    ```ruby
    require "mizlab"

    obj Mizlab.getobj("NC_012920")
    Mizlab.savefile("#{obj.accession}.gbk", obj)
    ```

- `fetch_taxon`
    TaxonomyID をもとに、NCBI の Taxonomy データベースから分類学の情報を取得します。
    ```ruby
    require "mizlab"

    human_taxon_id = 9606
    p Mizlab.fetch_taxon(human_taxon_id)
    # => [{:TaxId=>"131567", :ScientificName=>"cellular organisms", :Rank=>"no rank"}, {:TaxId=>"2759", :ScientificName=>"Eukaryota", :Rank=>"superkingdom"}, {:TaxId=>"33154", :ScientificName=>"Opisthokonta", :Rank=>"clade"}, {:TaxId=>"33208", :ScientificName=>"Metazoa", :Rank=>"kingdom"}, {:TaxId=>"6072", :ScientificName=>"Eumetazoa", :Rank=>"clade"}, {:TaxId=>"33213", :ScientificName=>"Bilateria", :Rank=>"clade"}, {:TaxId=>"33511", :ScientificName=>"Deuterostomia", :Rank=>"clade"}, {:TaxId=>"7711", :ScientificName=>"Chordata", :Rank=>"phylum"}, {:TaxId=>"89593", :ScientificName=>"Craniata", :Rank=>"subphylum"}, {:TaxId=>"7742", :ScientificName=>"Vertebrata", :Rank=>"clade"}, {:TaxId=>"7776", :ScientificName=>"Gnathostomata", :Rank=>"clade"}, {:TaxId=>"117570", :ScientificName=>"Teleostomi", :Rank=>"clade"}, {:TaxId=>"117571", :ScientificName=>"Euteleostomi", :Rank=>"clade"}, {:TaxId=>"8287", :ScientificName=>"Sarcopterygii", :Rank=>"superclass"}, {:TaxId=>"1338369", :ScientificName=>"Dipnotetrapodomorpha", :Rank=>"clade"}, {:TaxId=>"32523", :ScientificName=>"Tetrapoda", :Rank=>"clade"}, {:TaxId=>"32524", :ScientificName=>"Amniota", :Rank=>"clade"}, {:TaxId=>"40674", :ScientificName=>"Mammalia", :Rank=>"class"}, {:TaxId=>"32525", :ScientificName=>"Theria", :Rank=>"clade"}, {:TaxId=>"9347", :ScientificName=>"Eutheria", :Rank=>"clade"}, {:TaxId=>"1437010", :ScientificName=>"Boreoeutheria", :Rank=>"clade"}, {:TaxId=>"314146", :ScientificName=>"Euarchontoglires", :Rank=>"superorder"}, {:TaxId=>"9443", :ScientificName=>"Primates", :Rank=>"order"}, {:TaxId=>"376913", :ScientificName=>"Haplorrhini", :Rank=>"suborder"}, {:TaxId=>"314293", :ScientificName=>"Simiiformes", :Rank=>"infraorder"}, {:TaxId=>"9526", :ScientificName=>"Catarrhini", :Rank=>"parvorder"}, {:TaxId=>"314295", :ScientificName=>"Hominoidea", :Rank=>"superfamily"}, {:TaxId=>"9604", :ScientificName=>"Hominidae", :Rank=>"family"}, {:TaxId=>"207598", :ScientificName=>"Homininae", :Rank=>"subfamily"}, {:TaxId=>"9605", :ScientificName=>"Homo", :Rank=>"genus"}]
    ```

- `calculate_coordinates`
    配列をグラフ座標へ変換します。
    返り値は `[[x座標, ...], [y座標, ...], ...]` の形式です。
    ```ruby
    require "mizlab"

    seq = "atgc"
    mapping = { "a" => [1, 1], "t" => [-1, 1], "g" => [-1, -1], "c" => [1, -1] }
    p Mizlab.calculate_coordinates(seq, mapping)
    # => [[0.0, 1.0, 0.0, -1.0, 0.0], [0.0, 1.0, 2.0, 1.0, 0.0]]
    ```

- `local_patterns`
    座標をローカルパターンのヒストグラムに変換します。
    ```ruby
    require "mizlab"

    seq = "atgc"
    mapping = { "a" => [1, 1], "t" => [-1, 1], "g" => [-1, -1], "c" => [1, -1] }
    coordinates =  Mizlab.calculate_coordinates(seq, mapping)

    p local_patterns(coordinates[0], coordinates[1])
    # => 長さ512の配列が返ってきます
    ```

より詳しい内容（引数の型など）については[ここ](https://mizlab.github.io/Mizlab-ruby/Mizlab.html)を参考にしてください。

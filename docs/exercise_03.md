---
layout: default
title: 電子情報工学演習B 第3回
---

# 電子情報工学演習B 第3回

## 課題

> **アミノ酸配列の解析**
> [UniProt](https://www.uniprot.org/) のサイトから最新の SwissProt データベース (uniprot_sprot.fasta) をダウンロードし、以下の各項目について調べなさい。
> 1. 全エントリー数（項目数）
> 2. 総残基数
> 3. 登録されているアミノ酸配列長の平均、標準偏差、最大、最小
> 4. 配列長が最大と最小のエントリーの内容（どのようなタンパク質か、など）

## 準備

- データベースファイルをダウンロードする
    - ブラウザ上でダウンロードするか `curl` を使う
        ```console
        $ curl https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz -o "uniprot_sprot.fasta.gz"
        $ curl http://water.eit.hirosaki-u.ac.jp/~slmizu/MizutaLabo/B3Practice/uniprot_test.fasta -o "uniprot_test.fasta"
        ```
    - ファイルを解凍する
        ```console
        $ gzip -d uniprot_sprot.fasta.gz
        ```
    - テキストファイルなのに300MBくらいあるので閲覧するときは注意する
        ```console
        $ less uniprot_sprot.fasta
        ```

## 解法のヒント

- 項目数と残基数はループ内で数え上げすればOK
- 平均と標準偏差も定義を知っていればすぐ算出できる
    - Rubyで平方根を計算するときは `Math` モジュールを用いる
        ```ruby
        sd = Math.sqrt(根号の中身)
        ```

## 補足事項

### FASTA形式について

詳しい説明は [NCBI BLAST topics](https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=BlastHelp) にありますが、とりあえず [Wikipedia](https://ja.wikipedia.org/wiki/FASTA) を読んでおくと分かりやすいと思います。

> FASTA は、"FAST-Aye"（ファストエー）と発音する。

ということらしいのですが、皆さん「ファスタ」と呼んでいるようです。

### 標準偏差

各数量と平均の差を**偏差**(deviation)という。偏差の2乗の平均値を**分散**(variance)といい、データの散らばり具合を示す指標として用いられる。また、分散の正の平方根を**標準偏差**(standard deviation)という。
ここで標準偏差 $$s$$ は式 (1) のように表される。

$$
s=\sqrt{\overline{\mathstrut x^2}-(\overline{\mathstrut x})^2} \tag{1}
$$

このあたりの詳しい説明は
[【高校数学Ⅰ】分散s²と標準偏差s、分散の別公式 | 受験の月](https://examist.jp/mathematics/data/bunsan-hyoujyunhensa/)
を読むのがよいでしょう。
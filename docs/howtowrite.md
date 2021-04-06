---
layout: default
title: 記事の書き方
nav_order: 100
---

現時点でわかっている記事の書き方を記します。

1. このリポジトリをクローンする。
```console
$ git clone https://github.com/Omochice/mizlab-docs.git
```
あとでプルリクを作成するのでgithubのアカウントが必要です。

2. 作業用にブランチを切る。
```console
$ git switch -c <branch-name>
```
ブランチの名前は自由ですがわかりやすいもののほうがいいです。

3. 作業をする。
<!-- なんかyamlヘッダがうまいことレンダリングできないから段組みがずれる -->

```markdown
--- 
layout: <レイアウト名>
title: <title> # メニューやhtmlのタイトルになります
has_children: <bool> # 子記事を持つかどうか（非必須）
parent: <bool> # どの記事を親に持つか（非必須）
---

以下markdown形式で記事を記入できる
```
mdファイルの先頭にyaml形式でオプションを書きます。
他にもオプションはあるようですが最低限必要なのはこれぐらいでしょう。

1. 記事のレビュー
```console 
docker-compose up
```
このコマンドでdockerコンテナ内でjekyllが起動し、4000番ポートでサーバが起動します。
[localhost:4000]()に接続すればこのページと同等のものが見れます。

5. 作業をコミットする。
```console
$ git add <file>
$ git commit
```
コミットの粒度は細かいほうがいいと言われますが自由です。
ただし、複数作業を同一コミットに入れるのは望ましくないです。
また、issueに対応して解決した場合、コミットメッセージにissue番号を入れるとgithub側でうまいこと処理してくれます。

6. プルリクを作成する。
[プルリクエストの作成方法](https://docs.github.com/ja/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request)等を参照。
ここで、textlintでlintingを行い、通ったものをmainブランチにマージします。（予定）

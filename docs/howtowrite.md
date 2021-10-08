---
layout: default
title: 記事の書き方
nav_order: 100
---

現時点(2021/05/15)での記事の書き方を記します。

1. このリポジトリを fork する。
[github謹製のフォークの作り方](https://docs.github.com/ja/github/getting-started-with-github/fork-a-repo)を参考に自分のリポジトリに `MizLab/mizlab-docs` をフォークする。

1. fork したリポジトリを手元にクローンする。
```console
$ git clone https://github.com/<自分のユーザ名>/mizlab-docs.git
または
$ git clone git@github.com:<自分のユーザ名>/mizlab-docs.git 
```

1. fork 元のリポジトリを登録する。
このリポジトリの `main` ブランチが公開用のブランチです。
同期を取ってから作業を始めるとよいでしょう。
```console
fork元のリポジトリを`upstream`として登録する
$ git remote add upstream https://github.com/MizLab/mizlab-docs.git
upstreamと同期する
$ git fetch upstream
$ git switch main 
$ git merge upstream/main
```

1. 作業用にブランチを切る。
```console
$ git switch -c <branch-name>
```
ブランチの名前は自由ですがわかりやすいもののほうがいいです。

1. 作業をする。

   ```markdown
   --- 
   layout: <レイアウト名>
   title: <title> # メニューやhtmlのタイトルになります
   has_children: <bool> # 子記事を持つかどうか（非必須）
   parent: <bool> # どの記事を親に持つか（非必須）
   ---
   
   以下markdown形式で記事を記入できる
   ```
   md ファイルの先頭に yaml 形式でオプションを書きます。
   他にもオプションはあるようですが最低限必要なのはこれぐらいでしょう。

1. 記事のレビュー
```console 
$ docker-compose up
```
このコマンドで docker コンテナ内に jekyll が起動し、4000 番ポートでサーバが起動します。
[localhost:4000]()に接続すればこのページと同等のものが見れます。

1. 記事の表現の確認
`textlint`で日本語文書の表現の確認をします。
`textlint`がインストールされていない場合、次のコマンドでインストールします。
```console
# node.jsがインストールされている前提で記述しています。
$ npm install -g yarn 
$ yarn 
```
インストールができたら、次のコマンドで表現を確認します。
```console
$ textlint <作成したmarkdownファイル>
```
指摘されている部分があれば、修正をします。

1. 作業をコミットする。
```console
$ git add <file>
$ git commit
```
コミットの粒度は細かいほうがいいと言われますが自由です。
ただし、複数作業を同一コミットに入れるのは望ましくないです。
また、issue に対応して解決した場合、コミットメッセージに `close #<issue番号>` などを入れると github 側でうまいこと処理してくれます。

1. プルリクを作成する。
[プルリクエストの作成方法](https://docs.github.com/ja/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request)等を参照。
ここで、textlint で linting を行い、通ったものを main ブランチにマージします。（予定）

---
layout: default
title: 記事の書き方
nav_order: 100
---

現時点でわかっている記事の書き方を記します。

1. このリポジトリをforkする。
[https://docs.github.com/ja/github/getting-started-with-github/fork-a-repo]()を参考に自分のgithubにこのリポジトリをforkしてください。

1. forkしたリポジトリを手元にクローンする。
```console
$ git clone https://github.com/<自分のユーザ名>/mizlab-docs.git
または
$ git clone git@github.com:<自分のユーザ名>/mizlab-docs.git 
```

1. fork元のリポジトリを登録する。
このリポジトリの`main`ブランチが公開用のブランチです。
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
   mdファイルの先頭にyaml形式でオプションを書きます。
   他にもオプションはあるようですが最低限必要なのはこれぐらいでしょう。

1. 記事のレビュー
```console 
$ docker-compose up
```
このコマンドでdockerコンテナ内でjekyllが起動し、4000番ポートでサーバが起動します。
[localhost:4000]()に接続すればこのページと同等のものが見れます。

1. 作業をコミットする。
```console
$ git add <file>
$ git commit
```
コミットの粒度は細かいほうがいいと言われますが自由です。
ただし、複数作業を同一コミットに入れるのは望ましくないです。
また、issueに対応して解決した場合、コミットメッセージに`close #<issue番号>`などを入れるとgithub側でうまいこと処理してくれます。

1. プルリクを作成する。
[プルリクエストの作成方法](https://docs.github.com/ja/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request)等を参照。
ここで、textlintでlintingを行い、通ったものをmainブランチにマージします。（予定）

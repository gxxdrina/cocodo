<h1 align="center">ココドウ (cocodo?)</h1>
<p align="center">
  <img width="300" align="center" alt="cocodo" src="https://github.com/gxxdrina/cocodo/assets/127483650/1add9480-3105-499e-a441-eb0cc878d2f7">
</p>

## サイト概要

### サイトテーマ
「ここどう？」という観点で、  
旅行の写真を共有できる**旅行専用のSNSサイト**


### テーマを選んだ理由
みなさんは旅行先を決めるとき、どうしていますか？

本屋さんで旅行雑誌を見たり、「温泉」といったキーワードで検索をしたり、  
行き先が決まっていないと、候補地を探すのはなかなか難しいですよね。  
そのなかでも、旅行先の決め手となるのは、写真だと思います。

最近では、インスタグラムで旅行のおすすめスポットを紹介するアカウントが増えており、  
実際に、その投稿を見て旅行先を決める人も増えています。私もそのひとりです。  
そこで、旅行専用の写真投稿サイトを制作しようと考えました。

実際に行ったひとの写真や感想を参考にでき、いいねの数で人気度もわかります。  
旅行の予定がなくても、行ってみたいなと思った場所を保存しておけば、いつでも見返せるので、  
旅行へ行くときの候補地として役立ちます。

このサイトが、みなさんの素敵な旅行の手助けになれば、幸いです。


### ターゲットユーザ
- 旅行が好きな人
- 旅行の思い出を共有したい人
- 旅行の行き先を悩んでいる人


### 主な利用シーン
- おすすめの場所を共有する
- 旅行先の写真や思い出（感想）を記録し、整理する
- 行ってみたい場所を保存して、旅行の候補地に役立てる


## 設計書
### ER図
<img width="800" alt="cocodo" src="https://github.com/gxxdrina/cocodo/assets/127483650/4d2bd7cf-754e-4138-b60e-72a05a953e77">


## 管理者ログインに必要な情報
メールアドレス
```
admin@example.com  
```
パスワード
```
adminadmin  
```


## ローカル環境でのアプリケーションの起動
以下のコマンドを実行してアプリケーションを起動します。  
（ git方式 ）
```
$ git clone git@github.com:gxxdrina/cocodo.git
$ cd cocodo
$ bundle install
$ yarn install
$ rails db:create
$ rails db:migrate
$ rails db:seed
$ rails s
```


## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails, Bootstrap
- JSライブラリ：jQuery
- IDE：Cloud9


## 使用素材
- ロゴ：Canva (https://www.canva.com/)
- アイコン：Font Awesome (https://fontawesome.com/), Loose Drawing (https://loosedrawing.com/)
- フォント：Google fonts (https://fonts.google.com/)

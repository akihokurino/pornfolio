# README
## Sidekiq
非同期処理をサポートするgem。
`rails s`をしつつ、下記のコマンドを実行する必要がある。

```shell
$ bundle exec sidekiq -C config/sidekiq.yml
```

## Yeoman Configuration
compassとかをインストールするために`bundle install`しておく。

```shell
$ bundle install
```

node.jsがインストールされていること。

```shell
$ cd ng-app
$ npm install -g grunt-cli yo bower
$ npm install -g generator-angular
$ yo angular --minsafe
```

今は、既に上記の作業が済んでいるため、`grunt`を立ち上げるだけ。

```shell
$ grunt server
```
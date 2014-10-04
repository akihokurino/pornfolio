# VagrantとChefで快適な環境構築

- Macの場合、XcodeのCommand Line Toolのインストールがされていること
- Vagrantは[ここ](http://downloads.vagrantup.com/)からDLできます

```shell
# バージョンの確認
$ vagrant -v
```


## 必要なものをインストール

### knife-soloをインストール

```shell
# このとき一緒にchefもインストールされすはず
$ gem install knife-solo berkshelf
```

ローカルの`knife-solo`がもし0.2系であった場合は必ず0.3系以上にする必要があります。

```shell
$ knife configure
```

`~/.chef/knife.rb`にknifeの設定ファイルが保存されます。
色々聞かれるが、デフォルトのままでOKです。

### Vagrantのプラグインをインストール

```shell
# Chefが入っているか確認してインストールしてくれるプラグイン
$ vagrant plugin install vagrant-omnibus # Installed the plugin 'vagrant-omnibus (x.x.x)'!
# サードパーティのcookbookを使用するためのプラグイン
$ vagrant plugin install vagrant-berkshelf # Installed the plugin 'vagrant-berkshelf (x.x.x)'!

# サンドボックス機能が使える便利なプラグイン
$ vagrant plugin install sahara # Installed the plugin 'sahara (x.x.x)'!
```


## 仮想環境のベースとなるBoxファイルの準備

### Boxの準備
[http://www.vagrantbox.es/](http://www.vagrantbox.es/)から必要なOSのboxファイルをDLしてきて下さい。

```shell
# 今回はCentOS 6.4を使用
$ vagrant box add centos64 CentOS-6.4-x86_64-v20130427.box
$ vagrant box list # centos64という名のBoxが追加されていることを確認
```

## Vagrantfile

### Vagrantfileの作成

```shell
$ mkdir vagrant
$ cd vagrant
$ vagrant init centos64
```

### Vagrantfileの設定

```ruby
# 23行目のコメントアウトを外す
config.vm.network :private_network, ip:"192.168.33.10"
# rails -s が遅くなる場合は追加 (Macにnfsdが立ち上がってれば使える)
#config.vm.synced_folder ".", "/vagrant", nfs: true
# vagrant-omnibusを有効にする
config.omnibus.chef_version = :latest
# vagrant-berkshelfを有効にする
config.berkshelf.enabled = true
```

## 仮想マシンのlaunch
Vagrantfileと同じディレクトリで以下のコマンドを打ちます。

```shell
$ vagrant up
```

## sshで仮想マシンにログイン

```shell
$ vagrant ssh
```

今回はchefを使いやすくするために`ssh`コマンドでログインできるようにします。

```shell
$ vagrant ssh-config --host adult >> ~/.ssh/config
```

これで`ssh`でログインできるようになります。

```shell
$ ssh adult
```

### おまけ

`rsub`を使うとローカルマシンからSublime Textを使うことができます。
但し、事前にSublime TextのPackage Controlで`rsub`をインストールしておいてください。
`RemoteForward 52698 127.0.0.1:52698`を`~/.ssh/config`のホストに追加するとsshのトンネルが作成されます。

```
# vagrant ssh-config --host adult >> ~/.ssh/config で作られたホスト
Host adult
  HostName 127.0.0.1
  User vagrant
  Port 2222
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile "/Users/tadayuki/.vagrant.d/insecure_private_key"
  IdentitiesOnly yes
  LogLevel FATAL
  RemoteForward 52698 127.0.0.1:52698 # これを追加
```

`rsub`がvagrantで立てた仮想サーバーにインストールされていれば以下のコマンドでSublime Textで目的のファイルを開くことができます。

```shell
$ rsub [開きたいファイル]
```

## chefリポジトリの作成

```shell
$ knife solo init chef-repo
```

vagrantディレクトリの一つ上の階層が良いかもです。

## 仮想マシンをChefに対応

```shell
$ cd chef-repo
$ knife solo prepare adult
```


## 既存のcookbookを使用

### Berksfileの設定

インストールしたいものを`cookbook 'クックブック名'`で設定します。
これにより、依存するすべてのcookbookをインストールすることができます。

```
site :opscode
cookbook 'yum'
cookbook 'mysql'
cookbook 'database'
cookbook 'sudo'
```

### 既存のcookbokをインストール

```shell
# pathを指定しないと~/.berkshelf/cookbooksにインストールされる
$ berks --path cookbooks
```

## 自分でcookbookを作成

### cookbookを作成

```shell
$ knife cookbook create base -o site-cookbooks
```

`site-cookbooks/base`に色々作成されます。

`base/recipes/default.rb`にサーバーに動作させる処理を記載する。

### cookbookの指定

`node/adult.json`を編集して、動作させるcookbookを指定する。

```json
{
    "run_list":[
      "recipe[base]"
    ]
}
```

## knife soloの実行

```shell
$ knife solo cook adult
```

`adult.json`に指定されたcookbookが実行されます。
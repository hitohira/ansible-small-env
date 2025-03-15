ansible環境の簡単セットアップ

■作成されるもの
1台のansibleサーバと3台のhttpサーバ
3台はポート8081,8082,8083からWebブラウザでアクセス可能になる

■手順
# イメージのビルド
 sudo docker compose build

## イメージのビルド時にキャッシュを無効化して最新のパッケージを使う場合
sudo docker compose build --no-cache

# コンテナの起動
sudo docker compose up -d

# ansibleサーバにログイン
sudo docker compose exec ansible bash

# ansibleサーバ内でansibleユーザにスイッチ
su - ansible

# ターゲットノードのssh設定を行う(fingerprint取得と公開鍵転送）
cd work
./ssh-setting.sh

# ansibleのプレイブックを実行
ansible-playbook node-playbook.yml

# コンテナの停止(ansibleサーバからexitした後）
sudo docker compose down

# 古いコンテナイメージを削除する場合のコマンド
sudo docker image prune

■注意事項
・work/hostsにnodesを追加する際は、[all:vars]の前に空行を入れること
　→ssh-setting.shでは[nodes]以降空行前のnode名に対してsshの設定を行っている


■参考ページ
https://qiita.com/Shoma0210/items/7d7d24d7c3f95f19b427
https://qiita.com/sachiotomita/items/827f40d39c77b14ed902

centos7がEOSLのためcentos:stream9を使用
ansibleユーザを作成して鍵認証でplaybook実行



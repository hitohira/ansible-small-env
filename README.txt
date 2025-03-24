ansible環境の簡単セットアップ

■作成されるもの
1台のansibleサーバと3台のNode.jsアプリサーバとリバースプロキシサーバ
3台のアプリサーバはポート8081,8082,8083からWebブラウザでアクセス可能になる
リバースプロキシサーバはロードバランサとして動作し、アプリサーバにリクエストを振り分ける。ポート8080でアクセス可能。
design.txtも参照。

■手順
# イメージのビルド (キャッシュをクリアする場合は--no-cacheをつける）
 sudo docker compose build

# コンテナの起動
sudo docker compose up -d

# ansibleサーバにログイン
sudo docker compose exec ansible bash

# ansibleサーバ内でansibleユーザにスイッチ
su - ansible

# ターゲットノードのssh設定を行う(fingerprint取得と公開鍵転送のスクリプト）
cd work
./ssh-setting.sh

# ansibleのプレイブックを実行
ansible-playbook playbooks/site.yml

# コンテナの停止(ansibleサーバからexitした後）
sudo docker compose down

# 古いコンテナイメージを削除する場合のコマンド
sudo docker image prune

■注意事項
・work/inventory/hostsにnodeを追加する際は、ssh-setting.shも編集して公開鍵設定対象を追加すること
　→現在は[node]から空行までと[proxy]から空行までに記載のhost名を取得して鍵設定を行っている


■参考ページ
https://qiita.com/Shoma0210/items/7d7d24d7c3f95f19b427
https://qiita.com/sachiotomita/items/827f40d39c77b14ed902

centos7がEOSLのためcentos:stream9を使用
ansibleユーザを作成して鍵認証でplaybook実行



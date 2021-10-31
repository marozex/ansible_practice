# ローカル環境構築
## ssh準備/コンテナ作成
```shell
cd ansible_practice
ssh-keygen -t rsa -b 4096 -f .secret/id_rsa
docker-compose up -d
```

## ssh接続先変更
```shell
# local
ln -fs ssh_config.d/local ssh_config
ln -fs hosts.d/local hosts
```

## ssh実行
```shell
ssh sample-web01 -F ssh_config
```

# ansible実行
## 全て実行
```shell
ansible-playbook -i hosts main.yml
```

# テスト
## 方針
[pytest-testinfra](https://github.com/pytest-dev/pytest-testinfra)を利用

## 環境構築
## 本体インストール
```
pip install pytest-testinfra
```

## pycacheを作らないようにする
```
export PYTHONDONTWRITEBYTECODE=1
```

## サンプルテスト実行
```shell
cd medicinal-inventory-infra
# 例 sample-web01コンテナで実行
py.test -v tests/test.py --connection=ssh --hosts=sample-web01 --ssh-config=ssh_config
```
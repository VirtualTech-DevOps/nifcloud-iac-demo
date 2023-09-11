# nifcloud-iac-demo

```
.
├── ansible
│   └── install-pkgs.yml
└── terraform
    ├── main.tf
    ├── outputs.tf
    ├── terraform.tfvars
    ├── variables.tf
    └── versions.tf
```

## ニフクラにインスタンス作成

```
cd terraform
```

アカウント管理 > 自分のアカウント名からアクセスキーとシークレットキーを取得して環境変数にセット

```
export NIFCLOUD_ACCESS_KEY_ID=my-access-key
export NIFCLOUD_SECRET_ACCESS_KEY=my-secret-access-key
```

```
terraform init && terraform plan && terraform apply
```

terraform applyを実行するとカレントディレクトリに`nifcloud_rsa`と`ansible_inventory`というファイルができあがある。`nifcloud_rsa`はインスタンスにアクセスするためのSSHの秘密鍵、`ansible_inventory`はAnsibleから参照するためのインベンリー。両者とも`terraform destroy`で削除される。

## インスタンスのセットアップ

```
cd ansible
```

SSH初回実行時にホストのチェックが行われてる。yes/or聞かれるので止めたい場合は以下

```
export ANSIBLE_HOST_KEY_CHECKING=false
```

```
ansible-playbook -i ../terraform/ansible_inventory install-pkgs.yml
```

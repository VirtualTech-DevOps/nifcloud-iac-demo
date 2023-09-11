variable "region" {
  description = "リージョン/ゾーンは[こちら](https://pfs.nifcloud.com/service/zone.htm)"
  type        = string
}

variable "zone" {
  description = "リージョン/ゾーンは[こちら](https://pfs.nifcloud.com/service/zone.htm)"
  type        = string
}

variable "image_name" {
  type = string
}

variable "instances" {
  description = "起動するインスタンス数"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "サーバータイプは[こちら](https://pfs.nifcloud.com/service/spec.htm)"
  type        = string
  default     = "small"
}

variable "instance_accounting_type" {
  description = "1:月額課金 2:従量課金"
  type        = string
  default     = 2
}

variable "private_key_name" {
  type    = string
  default = "nifclud_rsa"
}

variable "private_key_algorithm" {
  description = "ニフクラはRSAに対応"
  type        = string
  default     = "RSA"
}

variable "private_key_rsa_bits" {
  type    = number
  default = 4096
}

variable "ansible_inventory_name" {
  description = "Ansibleから参照するインベントリファイル"
  type        = string
  default     = "ansible_inventory"
}

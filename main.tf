// main.tf - имя файла выбрано произвольно, важно только расширение
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

// Terraform должен знать ключ, для выполнения команд по API

// Определение переменной, которую нужно будет задать
variable "yc_token" {
    type        = string
    sensitive   = true
}

variable "fldr_id" {
    type        = string
}

provider "yandex" {
  zone = "ru-central1-a"
  token = var.yc_token
}

// ================================================
// Resources description


resource "yandex_vpc_network" "default" {
  folder_id = var.fldr_id
}

resource "yandex_vpc_subnet" "default" {
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["10.5.0.0/24"]
  folder_id      = var.fldr_id
}

// Получение данных из облака
data "yandex_compute_image" "img" {
  family = "ubuntu-2204-lts"
}
output "show-img" {
  value = data.yandex_compute_image.img
}

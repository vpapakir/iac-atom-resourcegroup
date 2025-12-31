terraform {
  cloud {
    organization = "vpapakir"
    workspaces {
      name = "resourcegroup-azure-dev"
    }
  }
}
resource "null_resource" "az_login" {
    provisioner "local-exec" {
        command = "az login -u ${var.aksadminuser} -p ${var.aksadminuserpassword}"
    }
}

resource "null_resource" "az_account_set" {
    provisioner "local-exec" {
        command = "az account set --subscription ${var.azsubscriptionid}"
    }

    depends_on = [
        null_resource.az_login
    ]
}

resource "null_resource" "az_aks_get_credentials" {
    provisioner "local-exec" {
        command = "az aks get-credentials --name ${var.aksname} --resource-group ${var.aksresourcegroup} --admin --overwrite-existing"
    }

    depends_on = [
        null_resource.az_account_set
    ]
}
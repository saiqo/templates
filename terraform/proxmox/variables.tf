variable  "pm_url" {
    default =  "https://<proxmox_ip>:8006/api2/json"
}
variable  "pm_api_token" {
    default =  "terraform@pve!terraform=<token>"
    sensitive = true
}

variable  "target_node" {
    default =  "<node_name>"
}

variable  "ssh_key" {
    default =  "<ssh_pub_keys>"
}

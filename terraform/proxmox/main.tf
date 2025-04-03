# Déploiement de deux VM Debian (Via clone d'un modèle)

resource "proxmox_virtual_environment_vm" "vm-proxmox" {
    count = 2 # Nombre de VM à créer

    node_name   = var.target_node

    name        = "debian-test-${count.index + 1}"
    tags 		= ["terraform", "debian"]
    description = "Managed by terraform"
    on_boot     = true

    agent {
        enabled = true
    }
    clone {
        vm_id = "8000" # ID du template à clone
        full = true
    }
    cpu {
        cores = "1"
        sockets = "2"
        type = "x86-64-v2-AES" # Utiliser "host" pour plus de performance
    }
    memory {
        dedicated = "2048"
    }
    network_device {
        model = "virtio"
        bridge = "vmbr0"
    }

    disk {
        datastore_id = "local-lvm"
        interface    = "scsi0"
        size    = 30 # Taille en Giga, Facultatif. Si renseigné, doit être + grand que le disque du template(resize)
    }

    initialization {
        ip_config {
            ipv4 {
                address = "192.168.1.17${count.index + 1}/24"
                gateway = "192.168.1.1"
            }
        }
        dns {
            servers = ["1.1.1.1", "8.8.8.8"]
        }
        user_account {
            keys     = [var.ssh_key]
            username = "saiqo"
            password = "toto"
        }
    }
}
resource "google_compute_instance" "vm-from-tf" {
  name = "vm-from-tf"
  zone = "asia-southeast1-a"
  machine_type = "e2-medium"
  #allow_stopping_for_update = true
  network_interface {
    network = "custom-vpc-tf"
    subnetwork = "sub-sg"
      }

boot_disk {
  initialize_params {
        image = "debian-10-buster-v20240417"
        size = 20 
  }
}
labels = {
  "env" = "tflearning"
}

service_account {
  email = "784041070432-compute@developer.gserviceaccount.com"
  scopes = [ "cloud-platform" ]
}
lifecycle {
  ignore_changes = [
    attached_disk
  ]
}

}

resource "google_compute_disk" "disk-1" {
  name = "disk-1"
  size = 15
  zone = "asia-southeast1-a"
  type = "pd-ssd"
}

resource "google_compute_attached_disk" "adisk" {
  disk = google_compute_disk.disk-1.id
  instance = google_compute_instance.vm-from-tf.id
}
resource "oci_objectstorage_bucket" "key_holder" {
  #Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  name           = "private-storage"
  namespace      = "ax47bun1ywrd"
}

resource "oci_objectstorage_object" "key_object" {
  #Required
  bucket    = oci_objectstorage_bucket.key_holder.name
  source    = "/home/urbino/.oci/id_public.pem"
  namespace = var.namespace
  object    = "id_rsa.pub"
}

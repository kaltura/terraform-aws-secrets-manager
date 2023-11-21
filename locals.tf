locals {
  secrets_names = { for key, value in var.secrets:
    key => try(value["tf_outputs"], false) ?
      (lookup(value, "cluster_name", false) != false ? ("/argocdValues/${try(value["secret_name_override"], key)}/${var.region}/${var.environment}/${value["cluster_name"]}/values.yaml") : ("/argocdValues/${try(value["secret_name_override"], key)}/${var.region}/${var.environment}/values.yaml"))
      : (lookup(value, "name_prefix", null) == null ? key : null) }
}

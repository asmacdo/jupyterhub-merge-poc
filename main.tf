locals {
  workspace_jupyterhub_yaml = "${path.module}/envs/${terraform.workspace}/z2jh_overrides.yaml"
  jupyterhub_base_config = yamldecode(templatefile("${path.module}/jupyterhub.yaml", {
    template_test = "TEMPLATED"
  }))

  jupyterhub_env_config = can(file(local.workspace_jupyterhub_yaml)) ? yamldecode(file(local.workspace_jupyterhub_yaml)) : {}

  jupyterhub_config = merge(local.jupyterhub_base_config, local.jupyterhub_env_config)
}

output "jupyterhub_config" {
  value = local.jupyterhub_config
}

resource "null_resource" "write_merged_yaml" {
  provisioner "local-exec" {
    command = "echo '${jsonencode(local.jupyterhub_config)}' > ${path.module}/merged_jupyterhub.yaml"
  }
}

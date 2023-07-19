data "cloudinit_config" "cloudinit-app" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = templatefile("userdata/init.cfg", {
      REGION = var.AWS_REGION
    })
  }

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("userdata/install-jenkins.sh", {
      DEVICE            = var.INSTANCE_DEVICE_NAME
      JENKINS_VERSION   = var.JENKINS_VERSION
      TERRAFORM_VERSION = var.TERRAFORM_VERSION
    })
  }
}


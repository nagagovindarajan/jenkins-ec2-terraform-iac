resource "aws_route53_zone" "jenkins-cloud" {
  name = "apps.jenkins.cloud"
}

resource "aws_route53_record" "jenkins-record" {
  zone_id = aws_route53_zone.jenkins-cloud.zone_id
  name    = "jenkins.apps.jenkins.cloud"
  type    = "A"
  alias {
    name                   = aws_alb.jenkins-lb.dns_name
    zone_id                = aws_alb.jenkins-lb.zone_id
    evaluate_target_health = true
  }
}

output "ns-servers" {
  value = aws_route53_zone.jenkins-cloud.name_servers
}

resource "aws_acm_certificate" "app_certificate" {
  domain_name       = "*.apps.jenkins.cloud"
  validation_method = "DNS"

  tags = {
    Name = "jenkins-cloud-certificate"
  }
}

resource "aws_route53_record" "certificate_verification" {
  zone_id = aws_route53_zone.jenkins-cloud.zone_id
  name    = tolist(aws_acm_certificate.app_certificate.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.app_certificate.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.app_certificate.domain_validation_options)[0].resource_record_value]
  ttl     = 300

  # Ensure the record is associated with the certificate's validation domain
  allow_overwrite = true
}
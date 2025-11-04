# ----------------------------------------------------
# Certificate
# ----------------------------------------------------
# for virginia region
resource "aws_acm_certificate" "virginia_cert" {
  provider = aws.virginia

  # domain_name       = "*.${var.subdomain_static}.${var.domain}"
  domain_name       = "${var.subdomain_static}.${var.domain}"
  validation_method = "DNS"

  tags = {
    Name = "${var.project}-${local.env}-wildcard-sslcert"

    Project = var.project
    Env     = local.env

  }
  lifecycle {
    create_before_destroy = true
  }
}

# ----------------------------------------------------
# Important: This resource should only be applied after the DNS validation record
# has been successfully created in Route53.
# ACM uses this record to verify domain ownership.
# If applied too early, the certificate validation may fail.
#
# Additionally: Be sure to explicitly specify the provider for this resource.
# ACM certificates for CloudFront must be created and validated in us-east-1 (N. Virginia).
# Without the correct provider, Terraform may attempt to validate the certificate in the wrong region,
# resulting in a "couldn't find resource" error even if the certificate is already issued.
# ----------------------------------------------------
resource "aws_acm_certificate_validation" "cert_validation" {
  provider                = aws.virginia
  certificate_arn         = aws_acm_certificate.virginia_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]

  depends_on = [aws_route53_record.cert_validation]

}


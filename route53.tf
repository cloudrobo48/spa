# # ----------------------------------------------------
# # Route53
# # ----------------------------------------------------
data "aws_route53_zone" "route53_existing_zone" {
  name = var.domain
}

# for route53 certification
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.virginia_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.route53_existing_zone.id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

# for cloudfront
resource "aws_route53_record" "cloudfront_alias" {
  zone_id = data.aws_route53_zone.route53_existing_zone.zone_id
  name    = "static.fieldwork48.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

# deleted 2025/10/22
# value : d2uizv8xdvwfk0.cloudfront.net.
# record name : fieldwork48.com
# type : A
# alias : Yes



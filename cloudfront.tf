# ----------------------------------------------------
# cloudfront cache distribution
# ----------------------------------------------------

resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled         = true
  is_ipv6_enabled = true
  comment         = "S3 origin CloudFront distribution"
  price_class     = "PriceClass_200"

  origin {
    domain_name = module.static_site_bucket.bucket_regional_domain_name
    origin_id   = "s3-origin"

    # OAI (Origin Access Identity) is used to grant CloudFront permission to access private S3 content.
    # It replaces public access with a signed identity, allowing CloudFront to retrieve objects securely.
    # The S3 bucket policy must explicitly allow this OAI ARN to perform s3:GetObject actions.
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-origin"

    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.virginia_cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = local.env

  }

  aliases = ["static.fieldwork48.com"]
  # aliases = [local.fqdn]

  default_root_object = "index.html"

  custom_error_response {
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 0
  }

  custom_error_response {
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 0
  }
}

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for accessing S3 static site"
}


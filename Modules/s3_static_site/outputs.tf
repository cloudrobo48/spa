output "bucket_name" {
  value = aws_s3_bucket.static_site.bucket
}  

# output "website_endpoint" {
#   value = aws_s3_bucket_website_configuration.static_site_config.website_endpoint
# }

output "bucket_regional_domain_name" {
  value       = aws_s3_bucket.static_site.bucket_regional_domain_name
  description = "S3 bucket regional domain name"
}

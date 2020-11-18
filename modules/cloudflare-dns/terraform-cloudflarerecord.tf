resource "cloudflare_record" "webapplication" {
  zone_id = var.cloudflare_zone_id
  name    = var.hostname
  value   = var.publicip
  type    = "A"
  proxied = var.proxied
  ttl     = var.dnsttl
}
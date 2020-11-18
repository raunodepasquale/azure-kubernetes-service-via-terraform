 variable "cloudflare_zone_id" {
     description = "The DNS zone ID to add the record to"
 }

 variable "proxied" {
     description = "Boolena, whether the record gets Cloudflare's origin protection"
     default = "true"
 }
 variable "dnsttl" {
     description = "The TTL, in seconds, of the record. It must be set to 1 if proxied is set to true"
     default = "1"
 }
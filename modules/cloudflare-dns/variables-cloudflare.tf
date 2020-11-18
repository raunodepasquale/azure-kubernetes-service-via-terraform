 variable "cloudflare_zone_id" {
     description = "The DNS zone ID to add the record to"
 }
 variable "hostname" {
     description = "The name of the record"
 }
 variable "publicip" {
     description = "The (string) value of the record"
 }
 variable "proxied" {
     description = "Boolena, whether the record gets Cloudflare's origin protection"
 }
 variable "dnsttl" {
     description = "The TTL, in seconds, of the record"
 }
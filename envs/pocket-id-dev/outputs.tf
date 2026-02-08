output "mealie_client_id" {
  value = pocketid_client.mealie_app.id
}

output "mealie_client_secret" {
  value     = pocketid_client.mealie_app.client_secret
  sensitive = true
}

output "paperless_ngx_client_id" {
  value = pocketid_client.paperless_ngx_app.id
}

output "paperless_ngx_client_secret" {
  value     = pocketid_client.paperless_ngx_app.client_secret
  sensitive = true
}

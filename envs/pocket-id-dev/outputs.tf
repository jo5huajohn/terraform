output "actual_client_id" {
  value = pocketid_client.actual_budget_app.id
}

output "actual_client_secret" {
  value     = pocketid_client.actual_budget_app.client_secret
  sensitive = true
}

output "mealie_client_id" {
  value = pocketid_client.mealie_app.id
}

output "mealie_client_secret" {
  value     = pocketid_client.mealie_app.client_secret
  sensitive = true
}

output "opencloud_client_id" {
  value = pocketid_client.opencloud_app.client_id
}

output "opencloud_android_client_id" {
  value = pocketid_client.opencloud_android_app.client_id
}

output "opencloud_ios_client_id" {
  value = pocketid_client.opencloud_ios_app.client_id
}

output "paperless_ngx_client_id" {
  value = pocketid_client.paperless_ngx_app.id
}

output "paperless_ngx_client_secret" {
  value     = pocketid_client.paperless_ngx_app.client_secret
  sensitive = true
}

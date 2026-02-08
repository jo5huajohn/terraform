resource "pocketid_group" "admin" {
  name          = "admin"
  friendly_name = "admin"
}

resource "pocketid_group" "users" {
  name          = "users"
  friendly_name = "users"
}

resource "pocketid_client" "mealie_app" {
  name = "Mealie"

  callback_urls = [
    "https://mealie.dev.lab42.me",
    "https://mealie.dev.lab42.me/login",
    "https://mealie.dev.lab42.me/login?direct=1",
  ]

  is_public                 = false
  pkce_enabled              = true
  requires_reauthentication = true
  launch_url = "https://mealie.dev.lab42.me"

  allowed_user_groups = [
    pocketid_group.admin.id,
    pocketid_group.users.id
  ]
}

resource "pocketid_client" "paperless_ngx_app" {
  name = "Paperless-ngx"

  callback_urls = [
    "https://paperless.dev.lab42.me/accounts/oidc/pocket-id/login/callback/",
  ]

  is_public                 = false
  pkce_enabled              = true
  requires_reauthentication = true
  launch_url = "https://paperless.dev.lab42.me"

  allowed_user_groups = [
    pocketid_group.admin.id,
    pocketid_group.users.id
  ]
}

library(connectapi)

if ( nchar(Sys.getenv("CONNECT_API_KEY")) ==0 ) {
  client <- connectapi:::create_first_admin(
    user = "admin",
    password = "admin0",
    email = "test@example.com"
  )
  connectapi:::update_renviron_creds(client$host, client$api_key, "CONNECT")
} else {
  client <- connect()
}

bnd <- bundle_dir("flask-restx")

cont <- deploy(client, bnd, name = "reprex20200414", access_type = "all")

poll_task(cont)

browse_dashboard(cont)

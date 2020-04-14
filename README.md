# Reprex Connect 20200414

## Setup

- Install the [`connectapi`](https://github.com/rstudio/connectapi) package
```
remotes::install_github("rstudio/connectapi")
```
- Note that the user/password for Connect are `admin`/`admin0`
- Create the reprex environment
```
docker-compose up -d

# add python packages to the site library
docker exec reprex-connect-20200414_rstudio-connect_1 /opt/python/3.6.5/bin/pip install flask-restx sklearn

# deploy the example
R -f deploy.R

# tear down the server
docker-compose down

# build it again
docker-compose up -d
```

## Problems

Notice that the content is now broken, because the underlying site library has
changed. 

This is undesirable for a number of reasons:
- Reproducibility of content is reduced
- As an admin, I may be lax about managing the site library
- As an admin, I did not opt into this behavior, and Connect usually isolates
  content / manages deployments for me / etc.
- As a publisher, this error is very confusing and I have no way to remedy
- Even figuring out "what" the issue is requires shell access on the server
- As a publisher, I have no real recourse to remedy the issue other than try to
  intuit how I need to change / redeploy my content
- The issue could pop up at any time that the python system library changes,
  between nodes, etc.
- Connect's contract of "content bundle reproducible over time" is much reduced
  without a way to purge these cached environments

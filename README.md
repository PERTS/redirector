# perts.me redirector

Very simple app to do flexible redirections from perts.me to neptune.perts.net/participate/portal.

* Allows https redirects
* Applies path and query string to the new domain

## Setup

1. Install `gcloud` and the python tools like all our other app engine projects. See [Tools for Web Development][1] for environment setup steps.
2. `npm start` (or use alias `npm run server`)
3. Visit localhost:8001 in your browser

## Behavior

### HTTPS redirects

Entering a URL in your browser with the https protocol requires a key exchange with _that domain_, before redirection. So the initially targeted domain needs to have a valid TLS certificate. This is non-trivial with some hosting providers, like GoDaddy.

Deploying to App Engine, which automatically manages free certificates, makes this simpler.

Note: the location of the 301 response will always use `https://`.

### Applying path and query string to redirect

We use this app at perts.me to redirect to neptune.perts.net/participate/portal. Any path or query string should be appended. For example:

|       URL        |                 301 redirect                 |
|------------------|----------------------------------------------|
| perts.me         | neptune.perts.net/participate/portal/        |
| perts.me/XYY     | neptune.perts.net/participate/portal/XYY     |
| perts.me/XYY?foo | neptune.perts.net/participate/portal/XYY?foo |

## Development

Build an app.yaml file with a redirection domain and/or path.

```
./build_app_yaml.sh neptune.perts.net/participate/portal
```

Then start the app.

```
npm start
```

It should respond with a 301:

```
$> curl -I http://localhost:8001/foo
HTTP/1.1 301 Moved Permanently
content-length: 0
location: https://neptune.perts.net/participate/portal/foo
cache-control: no-cache
content-type: text/html; charset=utf-8
Server: Development/2.0
Date: Mon, 16 May 2022 20:51:41 GMT
```

## Deployment

To deploy, run the deploy script and specify the project ID and where to redirect. Assumes the App Engine version is "production".

```
npm run deploy perts-me neptune.perts.net/participate/portal
```

To deploy to another version for testing:

1. Make sure to generate the correct app.yaml file with the intended redirect.
2. Use a custom gcloud command. Don't forget `--no-promote`!

```
./build_app_yaml.sh custom-domain.org
gcloud app deploy app.yaml --project=perts-me --version=acceptance --no-promote
```

[1]: https://docs.google.com/document/d/184dsSF-esWgJ-TS_da3--UkFNb1oIur-r99X-7Xmhfg/edit

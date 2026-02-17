# perts.me redirector

Very simple app to do flexible redirections and serve static assets.

- Allows https redirects
- Applies path and query string to the new domain

⚠️ IMPORTANT ⚠️ - This app, hosted at perts.me, is the entrypoint for all PERTS survey participants because it redirects to copilot.perts.net/portal. Deployments to project `perts-me` with version `production` should only be done with the utmost caution.

It is also used at our domain neptune.perts.net, which serves to:

- redirect users with legacy portal links to the correct portal
- serve static assets for Qualtrics surveys CB and CG

## Setup

- Install `gcloud` and the python tools like all our other app engine projects. See [Tools for Web Development][1] for environment setup steps.
- Install python dependencies:

    ```bash
    python3 -m venv venv
    source venv/bin/activate

    pip install -r requirements.txt
    ```

Note: To deactivate the virtual environment when you're done, run `deactivate`.

## Behavior

### HTTPS redirects

Entering a URL in your browser with the https protocol requires a key exchange with _that domain_, before redirection. So the initially targeted domain needs to have a valid TLS certificate. This is non-trivial with some hosting providers, like GoDaddy.

Deploying to App Engine, which automatically manages free certificates, makes this simpler.

Note: the location of the 301 response will always use `https://`.

### Applying path and query string to redirect

We use this app at perts.me to redirect to copilot.perts.net/portal. Any path or query string should be appended. For example:

| URL              | 301 redirect                     |
| ---------------- | -------------------------------- |
| perts.me         | copilot.perts.net/portal/        |
| perts.me/XYY     | copilot.perts.net/portal/XYY     |
| perts.me/XYY?foo | copilot.perts.net/portal/XYY?foo |

## Development

Build an .env file with a redirection domain and/or path.

```
npm run build copilot.perts.net/portal
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
location: https://copilot.perts.net/portal/foo
cache-control: no-cache
content-type: text/html; charset=utf-8
Server: Development/2.0
Date: Mon, 16 May 2022 20:51:41 GMT
```

Note that the local server uses `gunicorn` and not an app engine emulator, so it is not aware of `app.yaml`. Any redirects or static asset handlers in `app.yaml` will not have an effect. Instead, it looks at `.env` for the redirect, because it's simpler to parse than a YAML file.

The deployed code only sees the `app.yaml` file.

## Deployment to perts.me

To deploy, run the deploy script and specify the app engine version and where to redirect. You can use the "acceptance" version for testing deployments:

```
./deploy_perts_me.sh acceptance copilot.perts.net/portal
```

Use the "production" version to change the behavior of perts.me (with caution!).

The build script will ask you to confirm, and gcloud CLI will confirm the deployment a second time. Double check the project and version before continuing.

[1]: https://docs.google.com/document/d/184dsSF-esWgJ-TS_da3--UkFNb1oIur-r99X-7Xmhfg/edit

## Deployment to neptune.perts.net

To deploy, run the deploy script and specify the app engine version and where to redirect. You can use the "acceptance" version for testing deployments:

```
./deploy_neptune.sh acceptance copilot.perts.net/portal
```

Use the "redirector" version to change the behavior of neptune.perts.net (with caution!) which will affect Qualtrics surveys and legacy survey portal links.

Note that this specialize deploy script will also add entries to app.yaml for static assests used in Qualtrics surveys.

The build script will ask you to confirm, and gcloud CLI will confirm the deployment a second time. Double check the project and version before continuing.

# perts.me redirector

Very simple app to do flexible redirections from perts.me to neptune.perts.net/participate/portal.

## Setup

1. Install `gcloud` and the python tools like all our other app engine projects. See [Tools for Web Development][1] for environment setup steps.
2. `npm start` (or use alias `npm run server`)
3. Visit localhost:8001 in your browser

## Behavior

Visiting this app should redirect you to neptune.perts.net/participate/portal. Any path or query string should be appended. For example:

|       URL        |                 301 redirect                 |
|------------------|----------------------------------------------|
| perts.me         | neptune.perts.net/participate/portal/        |
| perts.me/XYY     | neptune.perts.net/participate/portal/XYY     |
| perts.me/XYY?foo | neptune.perts.net/participate/portal/XYY?foo |


[1]: https://docs.google.com/document/d/184dsSF-esWgJ-TS_da3--UkFNb1oIur-r99X-7Xmhfg/edit

from google.appengine.ext import webapp


class AllHandler(webapp.RequestHandler):
    def get(self):
        self.redirect(
            "https://neptune.perts.net/participate/portal{}".format(
                self.request.path_qs
            ),
            code=301,
        )

    def head(self):
        self.get()
        self.response.clear()


application = webapp.WSGIApplication([('/.*', AllHandler)])

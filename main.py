from google.appengine.ext import webapp
import os


class AllHandler(webapp.RequestHandler):
    def get(self):
        redirect_to = os.environ.get('REDIRECT_TO', None)

        if redirect_to is None:
            raise Exception(
                'Environment variable REDIRECT_TO not set. Use the deploy '
                'script for proper configuration.'
            )

        self.redirect(
            "https://{redirect_to}{path_with_query_string}".format(
                redirect_to=redirect_to,
                path_with_query_string=self.request.path_qs,
            ),
            code=301,
        )

    def head(self):
        self.get()
        self.response.clear()


application = webapp.WSGIApplication([('/.*', AllHandler)])

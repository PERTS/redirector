from google.appengine.ext import webapp
# from google.appengine.ext.webapp.util import run_wsgi_app


class AllHandler(webapp.RequestHandler):
    def get(self):
        self.redirect("https://neptune.perts.net/participate", code=301)

    def head(self):
        self.get()
        self.response.clear()


application = webapp.WSGIApplication([('/.*', AllHandler)])


# def main():
#     run_wsgi_app(application)

# if __name__ == "__main__":
#     main()

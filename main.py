from flask import Flask, redirect, request
import os


app = Flask(__name__)


@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def redirect_all(path):
    redirect_to = os.environ.get('REDIRECT_TO', None)

    if redirect_to is None:
        raise Exception(
            'Environment variable REDIRECT_TO not set. Use the deploy '
            'script for proper configuration.'
        )

    # Reconstruct the full path with query string
    path_with_query = request.full_path.rstrip('?')
    
    return redirect(
        f"https://{redirect_to}{path_with_query}",
        code=301,
    )


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)

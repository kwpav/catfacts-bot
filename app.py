#!/usr/bin/env python

from flask import Flask, request
import hy
import slash

app = Flask(__name__)


# @app.route('/catfacts', methods=['POST'])
# def slash_catfacts():
#     return slash.handle_slash(request.form["token"])


if __name__ == '__main__':
    app.run()

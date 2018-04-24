#!/usr/bin/env python

from flask import Flask, request
import hy
import slash

app = Flask(__name__)


@app.route('/catfacts', methods=['POST'])
def slash_catfacts():
    return slash.slash_response(request.form["token"])


if __name__ == '__main__':
    app.run()

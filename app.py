#!/usr/bin/env python

from flask import Flask, jsonify, request
import os
import hy
import catfactsbot
import slash

verification_token = os.environ["VERIFICATION_TOKEN"]

app = Flask(__name__)


@app.route('/catfacts', methods=['POST'])
def slash():
    return slash.handle_slash(request.form["token"], verification_token)


if __name__ == '__main__':
    app.run()

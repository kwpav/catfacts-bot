#!/usr/bin/env python

from flask import Flask, jsonify, request
import os
import hy
import catfactsbot

verification_token = os.environ["VERIFICATION_TOKEN"]

app = Flask(__name__)


@app.route('/catfacts', methods=['POST'])
def slash():
    if request.form['token'] == verification_token:
        payload = {'text': catfactsbot.random_fact()}
        return jsonify(payload)


if __name__ == '__main__':
    app.run()

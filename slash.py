#!/usr/bin/env python

from flask import Flask, jsonify, request
import os

verification_token = os.environ["VERIFICATION_TOKEN"]

app = Flask(__name__)


@app.route('/catfacts', methods=['POST'])
def slash():
    if request.form['token'] == verification_token:
        payload = {'text': 'DigitalOcean Slack slash command is successful!'}
        return jsonify(payload)


if __name__ == '__main__':
    app.run()

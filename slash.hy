(import os
        [flask [Flask jsonify request]]
        [catfactsbot [random-fact]])

(setv app (Flask __name__))

(setv verification-token (.get os.environ "VERIFICATION_TOKEN"))

(with-decorator (app.route "/catfacts" :methods ["POST"])
  (defn handle-slash [form-token]
    (if (= (get request.form "token") verification-token)
        (with [(.app_context app)]
          (jsonify {"response_type" "in_channel"
                    "text" (random-fact)})))))

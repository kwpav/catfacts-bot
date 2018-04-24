(import os
        [flask [Flask jsonify]]
        [catfactsbot [random-fact]])

(setv app (Flask __name__))

(setv verification-token (.get os.environ "VERIFICATION_TOKEN"))

(defn slash-response [form-token]
  "Respond with a catfact when /catfacts is called"
  (if (= form-token verification-token)
      (with [(.app_context app)]  ;; needed for jsonify to work
        (jsonify {"response_type" "in_channel"
                  "text" (random-fact)}))
      None))

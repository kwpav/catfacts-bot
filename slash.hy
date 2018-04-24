(import [flask [Flask jsonify]]
        [catfactsbot [random-fact]])

(setv app (Flask __name__))

(setv verification-token (.get os.environ "VERIFICATION_TOKEN"))

(defn handle-slash [form-token]
  (if (= form-token verification-token)
      (with [(.app_context app)]
        (jsonify {"response_type" "in_channel"
                  "text" (random-fact)}))))

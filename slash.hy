(import [flask [Flask jsonify]]
        [catfactsbot [random-fact]])

(setv app (Flask __name__))

(defn handle-slash [form-token verification-token]
  (if (= form-token verification-token)
      (with [(.app_context app)]
        (jsonify {"response_type" "in_channel"
                  "text" (random-fact)}))))

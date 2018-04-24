(import [flask [jsonify]]
        [catfactsbot [random-fact]])

(defn handle-slash [form-token verification-token]
  (if (= form-token verification-token)
      (jsonify {"response_type" "in_channel"
                "text" (random-fact)})))

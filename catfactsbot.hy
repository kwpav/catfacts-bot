(import os
        [slackclient [SlackClient]]
        [random [randint]]
        [time [sleep]])

;; FACTS
(setv facts (with [f (open "facts.txt" "r")]
              (.readlines f)))

(defn random-fact []
  (nth facts (randint 0 (- (len facts) 1))))

;; SLACK
(setv key (.get os.environ "SLACK_BOT_TOKEN"))
(setv slack (SlackClient key))

(defn message-channel [channel text]
  (slack.api_call "chat.postMessage"
                  :channel channel
                  :text text))

;; the range of time to wait between facts, in minutes
(defn wait-time [i j] (cons i (cons j '())))
(setv wait-min first)
(setv wait-max last)

(defn minutes [n]
  (* 60 n))

(defn wait [times] (sleep (randint
                            (minutes (wait-min times))
                            (minutes (wait-max times)))))

(setv wait-times (wait-time 1 2))

(defn start []
  (message-channel "#general"
                   (random-fact))
  (wait wait-times)
  (start))

(defmain [&rest args]
  (start))

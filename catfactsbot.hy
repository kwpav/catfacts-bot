(import os
        [slackclient [SlackClient]]
        [random [randint]]
        [time [sleep]])

;; FACTS
(setv facts (with [f (open "facts.txt" "r")]
              (.readlines f)))

(defn random-fact []
  "Return a random fact from facts.txt"
  (nth facts (randint 0 (- (len facts) 1))))

;; SLACK
(setv key (.get os.environ "SLACK_BOT_TOKEN"))
(setv slack (SlackClient key))

(defn message-channel [channel text]
  "Send a message to a given channel"
  (slack.api_call "chat.postMessage"
                  :channel channel
                  :text text))

(defn wait-time [i j]
  "Set the range of the time to wait between messages, in minutes"
  (list i j))
(setv wait-min first)
(setv wait-max last)

(defn minutes [n]
  "Seconds to minutes"
  (* 60 n))

(defn wait [times]
  "Wait for a random amount of time between the range of times given"
  (sleep (randint (minutes (wait-min times))
                  (minutes (wait-max times)))))

(setv wait-times (wait-time 1 2))

(defn start []
  "Start the bot"
  (message-channel "#general"
                   (random-fact))
  (wait wait-times)
  (start))

(defmain [&rest args]
  (start))

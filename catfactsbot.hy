(import os
        re
        [slackclient [SlackClient]]
        [random [randint]]
        [time [sleep]])

;; FACTS
(setv facts (with [f (open "facts.txt" "r")]
              (.readlines f)))

(defn random-fact []
  "Return a random fact from facts.txt"
  (nth facts (randint 0
                      (- (len facts) 1))))

;; SLACK
(setv slack-key (.get os.environ "SLACK_BOT_TOKEN"))
(setv slack (SlackClient slack-key))
(setv slack-api-call slack.api_call)  ; make api_call look like a lisp functino
(setv rtm-read-delay 1)  ; 1 second delay when reading from RTM



;; general - C9S02TBKR
;; random - C9QBQ3BAM
;; my id - U9RPGANMC
(defn message-channel [channel text]
  "Send a message to a given channel"
  (slack-api-call "chat.postMessage"
                  :channel channel
                  :text text))

(defn slack-parse-channel [slack-events]
  "Parses list of events and sends a cat fact on direct mention"
  (for [event slack-events]
    (if (direct-mention? event)
        (message-channel (get event "channel")
                         (random-fact)))))

(defn direct-mention? [event]
  "Determines if the user id is mentioned at the beginning of the message"
  (setv mention-regex "^<@(|[WU].+?)>(.*)")  ; regex to look for @catfacts
  (and (= (get event "type") "message")
       (.search re mention-regex (get event "text"))))

(defn make-wait-range [i j]
  "Set the range of the time to wait between messages, in minutes"
  [i j])

(setv wait-min first)
(setv wait-max last)

(defn minutes [n]
  "Seconds to minutes"
  (* 60 n))

;; TODO make this not use sleep so the RTM stuff still works
;; use some sort of stopwatch?
(defn wait [times]
  "Wait for a random amount of time between the range of times given"
  (sleep (randint (minutes (wait-min times))
                  (minutes (wait-max times)))))

(setv wait-range (make-wait-range 1 2))

(setv subscribers ["U9RPGANMC"])

(defn start []
  "Start the bot"
  ;; (message-channel "#general"
  ;;                  (random-fact))
  ;; (wait wait-range)
  ;; (start))
  (if (.rtm_connect slack :with_team_state False)
      (do
        (for [user subscribers]
          (message-channel user (random-fact)))
        (while slack.server.connected
          (slack-parse-channel (slack.rtm_read)))
        (sleep rtm-read-delay))
      (print "Failed to connect")))

(defmain [&rest args]
         (start))

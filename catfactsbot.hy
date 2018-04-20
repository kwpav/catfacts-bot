(import os
        [slackclient [SlackClient]]
        [random [randint]]
        [time [sleep]])

;; FACTS
(setv facts
      '("The cat was seen as a sacred animial in ancient Eqypt, and the history of domestic cats dates back to as early as 8000 years."
        "The biggest breed of domesticated cats are called a Maine Coon cat and weighs up to 11 kg."
        "Cats are some of the smartest animals and can interpret a human's mood and feelings."
        "The average cat sleeps between 12-14 hours a day."
        "Cats paw (repeatedly treading on a spot - often it's owner) to mark their territory. Cats sweat through the bottom of their paws and rub this off as a marking mechanism."
        "Cats can be taught how to use the toilet."
        "White cats with blue eyes are quite often born deaf."
        "Cat urine glows in the dark if a black light is shined on it. This is a good way to detect cat urine in your home."
        "Cats have 220° field of view where humans only have 180°."
        "Cats' sense of smell is 14 times stronger than that of humans."
        "Cats have 30 permanent teeth, while adult humans have 32."
        "Cats have 30 vertebrae, while humans only have 25."
        "Cats have 230 bones in their bodies, this is 24 more than humans."
        "Cats have a body temperature of between 101 and 102.2 °F (38 and 39 °C)."
        "The lifespan of cats are usually between 15 and 20 years."
        "Cats have a heart rate of between 120 - 240 beats per minute. (This varies highly between different breeds cats)"
        "Cats take between 20 - 40 breaths per minute in an inactive state. (This varies highly between different breeds cats)"
        "The print on a cat's nose is like that of a fingerprint of a human, each is unique."
        "Cats have a top speed of about 30 mp/h (48.28 km/h)."))

(defn random-fact []
  (nth facts (randint 0 (- (len facts) 1))))

;; SLACK
(setv key (.get os.environ "SLACK_BOT_TOKEN"))
(setv slack (SlackClient key))

(defn message-channel [channel text]
  (slack.api_call "chat.postMessage"
                  :channel channel
                  :text text))

(defn minutes [n]
  (* 60 n))

(defn start []
  (do
    (message-channel "#general"
                     (random-fact))
    (sleep (randint (minutes 1) (minutes 2))))
  (start))

(defmain [&rest args]
  (do
    (start)
    (print "catfacts-bot is purring along")))

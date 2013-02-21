;; for emacs-mozc
(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")

(setq its-hira-comma "，")
(setq its-hira-period "．")
(eval-after-load "its"
  '(define-its-state-machine-append its-hira-map
     (its-defrule "dhi" "でぃ")
     (its-defrule "dhu" "でゅ")
     (its-defrule "thi" "てぃ")
     (its-defrule "thu" "てゅ")
     (its-defrule "whi" "うぃ")
     (its-defrule "whe" "うぇ")
     (its-defrule "who" "うぉ")))
(toggle-input-method nil)
(setq its-enable-fullwidth-alphabet nil)

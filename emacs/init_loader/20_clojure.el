;; setup for clojure
(autoload 'clojure-mode "clojure-mode")

(defun my/clojure-mode-hook ()
  (if (featurep 'slime-mode)
      (call-interactively 'slime-mode)))

(add-hook 'clojure-mode-hook #'my/clojure-mode-hook)

(eval-after-load "clojure-mode"
  '(progn
     (require 'inf-clojure)
     (push '("*clojure*" :stick t) popwin:special-display-config)))

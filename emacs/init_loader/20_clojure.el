;; setup for clojure
(require 'clojure-mode)

(defun my/clojure-mode-hook ()
  (if (featurep 'slime-mode)
      (call-interactively 'slime-mode)))

(add-hook 'clojure-mode-hook #'my/clojure-mode-hook)

(push '("*clojure*" :stick t) popwin:special-display-config)

;; inferior-clojure
(require 'inf-clojure)

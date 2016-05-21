;;;; Window configuration

;; popwin
(require 'popwin)

(defvar popwin:special-display-config-backup popwin:special-display-config)
(custom-set-variables
 '(display-buffer-function 'popwin:display-buffer))

;; remove from default config
(dolist (stuff '("*vc-diff*" "*vc-change-log*"))
  (delete stuff popwin:special-display-config))

;; basic
(push '("*Help*" :stick t :noselect t) popwin:special-display-config)
(push '("*sdic*") popwin:special-display-config)

;; Ruby
(push '("*ri-doc*" :stick t :height 20) popwin:special-display-config)
(push '(inf-ruby-mode :stick t :height 20) popwin:special-display-config)

;; python
(push '("*Python*"   :stick t) popwin:special-display-config)
(push '("*Python Help*" :stick t :height 20) popwin:special-display-config)
(push '("*jedi:doc*" :stick t :noselect t) popwin:special-display-config)

;; Go
(push '("^\*go-direx:" :position left :width 0.3 :dedicated t :stick t :regexp t)
      popwin:special-display-config)

;; flycheck
(push '(flycheck-error-list-mode :stick t) popwin:special-display-config)

;; CoffeeScript
(push '("*CoffeeREPL*" :stick t) popwin:special-display-config)

;; Clojure
(push '(cider-repl-mode :stick t) popwin:special-display-config)

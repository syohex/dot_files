;;;; popwin
(require 'popwin)
(defvar popwin:special-display-config-backup popwin:special-display-config)
(custom-set-variables
 '(display-buffer-function 'popwin:display-buffer))

;; basic
(push '("*Help*" :stick t :noselect t) popwin:special-display-config)

;; popwin for slime
(push '(slime-repl-mode :stick t) popwin:special-display-config)

;; man
(push '(Man-mode :stick t :height 20) popwin:special-display-config)

;; Elisp
(push '("*ielm*" :stick t) popwin:special-display-config)
(push '("*eshell pop*" :stick t) popwin:special-display-config)

;; Ruby
(push '("*ri-doc*" :stick t :height 20) popwin:special-display-config)
(push '(inf-ruby-mode :stick t :height 20) popwin:special-display-config)

;; prolog
(push '(prolog-inferior-mode :stick t :height 20) popwin:special-display-config)

;; erlang
(push '(erlang-shell-mode :stick t) popwin:special-display-config)

;; python
(push '("*Python*"   :stick t) popwin:special-display-config)
(push '("*Python Help*" :stick t :height 20) popwin:special-display-config)
(push '("*jedi:doc*" :stick t :noselect t) popwin:special-display-config)

;; Haskell
(push '("*haskell*" :stick t) popwin:special-display-config)
(push '("*GHC Info*") popwin:special-display-config)

;; sgit
(push '("*sgit*" :position right :width 0.5 :stick t)
      popwin:special-display-config)

;; direx
(push '(direx:direx-mode :position left :width 40 :dedicated t)
      popwin:special-display-config)

;; Go
(push '("\*godoc\*" :stick t :noselect t) popwin:special-display-config)
(push '("^\*go-direx:" :position left :width 0.3 :dedicated t :stick t :regexp t)
      popwin:special-display-config)

;; flycheck
(push '(flycheck-error-list-mode :stick t) popwin:special-display-config)

;; CoffeeScript
(push '("*CoffeeREPL*" :stick t) popwin:special-display-config)

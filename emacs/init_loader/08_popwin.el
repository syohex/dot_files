;;;; popwin
(require 'popwin)
(global-set-key (kbd "M-z") popwin:keymap)
(global-set-key (kbd "C-x l") 'popwin:popup-last-buffer)
(global-set-key (kbd "C-x SPC") 'popwin:select-popup-window)

(defvar popwin:special-display-config-backup popwin:special-display-config)
(custom-set-variables
 '(display-buffer-function 'popwin:display-buffer))

;; remove from default config
(cl-loop for stuff in '("*vc-diff*" "*vc-change-log*")
         do (delete stuff popwin:special-display-config))

;; basic
(push '("*Help*" :stick t :noselect t) popwin:special-display-config)

;; popwin for sly
(push '(sly-mrepl-mode :stick t) popwin:special-display-config)

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

;; direx
(push '(direx:direx-mode :position left :width 40 :dedicated t)
      popwin:special-display-config)

;; Go
(push '("^\*go-direx:" :position left :width 0.3 :dedicated t :stick t :regexp t)
      popwin:special-display-config)

;; flycheck
(push '(flycheck-error-list-mode :stick t) popwin:special-display-config)

;; CoffeeScript
(push '("*CoffeeREPL*" :stick t) popwin:special-display-config)

;; Ocaml
(push '("*ocaml-toplevel*" :stick t) popwin:special-display-config)

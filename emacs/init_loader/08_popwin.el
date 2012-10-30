;;;; popwin
(require 'popwin)
(defvar popwin:special-display-config-backup popwin:special-display-config)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:special-display-config
      (append '(("*Apropos*") ("*quickrun*" :stick t)
                ("*Faces*" :stick t) ("*Colors*" :stick t) ("*Help*" :stick t))
              popwin:special-display-config))
(push '("*sdic*" :stick t) popwin:special-display-config)
(push '("*haskell*" :stick t) popwin:special-display-config)
(push '("*ielm*" :stick t) popwin:special-display-config)

;; popwin for slime
(push '(slime-repl-mode :stick t) popwin:special-display-config)

;; man
(push '(Man-mode :stick t :height 20) popwin:special-display-config)

;; eshell
(push '("*eshell pop*" :stick t) popwin:special-display-config)

;; pry
(push '(inf-ruby-mode :stick t :height 20) popwin:special-display-config)

;; python
(push '("*Python*"   :stick t) popwin:special-display-config)
(push '("*jedi:doc*" :stick t) popwin:special-display-config)

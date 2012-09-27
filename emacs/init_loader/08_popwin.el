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
(push '("*slime-apropos*") popwin:special-display-config)
(push '("*slime-macroexpansion*") popwin:special-display-config)
(push '("*slime-description*") popwin:special-display-config)
(push '("*slime-compilation*" :noselect t) popwin:special-display-config)
(push '("*slime-xref*") popwin:special-display-config)
(push '(sldb-mode :stick t) popwin:special-display-config)
(push '(slime-repl-mode :stick t) popwin:special-display-config)
(push '(slime-connection-list-mode) popwin:special-display-config)

;; man
(push '(Man-mode :stick t :height 20) popwin:special-display-config)

;; eshell
(push '("*eshell pop*" :stick t) popwin:special-display-config)

;; sgit
(push '("*sgit*" :height 20) popwin:special-display-config)

;;;; popwin
;; (install-elisp "https://github.com/m2ym/popwin-el/raw/master/popwin.el")
(require 'popwin)
(defvar popwin:special-display-config-backup popwin:special-display-config)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:special-display-config
      (append '(("*Apropos*") ("*quickrun*" :stick t)
                ("*Faces*" :stick t) ("*Colors*" :stick t) ("*Help*" :stick t))
              popwin:special-display-config))

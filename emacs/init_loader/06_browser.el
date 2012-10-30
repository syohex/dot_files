;; configuration of emacs-w3m
(add-to-list 'load-path "~/.emacs.d/elisps/emacs-w3m")
(require 'w3m-load)

;; set default browser
(setq browse-url-browser-function 'browse-url-firefox)

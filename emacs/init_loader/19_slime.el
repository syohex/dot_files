;;; slime
(add-to-list 'load-path "~/.emacs.d/repos/slime")
(require 'slime)
(slime-setup '(slime-repl slime-fancy slime-banner))

;; encoding
(setq slime-net-coding-system 'utf-8-unix)

;;; popwin for slime
(push '("*slime-apropos*") popwin:special-display-config)
(push '("*slime-macroexpansion*") popwin:special-display-config)
(push '("*slime-description*") popwin:special-display-config)
(push '("*slime-compilation*" :noselect t) popwin:special-display-config)
(push '("*slime-xref*") popwin:special-display-config)
(push '(sldb-mode :stick t) popwin:special-display-config)
(push '(slime-repl-mode :stick t) popwin:special-display-config)
(push '(slime-connection-list-mode) popwin:special-display-config)

;; faces
(set-face-foreground 'slime-repl-inputed-output-face "pink1")

;; ac-slime
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))

(require 'popwin-w3m)
(push '("^file://.*HyperSpec.*\\.htm$" :height 0.4)
      popwin:w3m-special-display-config)
(defadvice slime-hyperspec-lookup (around hyperspec-lookup-around activate)
  (let ((browse-url-browser-function 'popwin:w3m-browse-url))
    ad-do-it))

;; for clojure
(setq slime-protocol-version 'ignore)

;;; slime
(add-to-list 'load-path "~/.emacs.d/elisps/slime")
(add-to-list 'load-path "~/.emacs.d/elisps/slime/contrib")

(require 'slime)
(define-key slime-mode-map (kbd "C-M-i") 'auto-complete)

;; SLIME REPL
(slime-setup '(slime-repl slime-fancy slime-banner))

(define-key slime-repl-mode-map (kbd "TAB") nil)
(define-key slime-repl-mode-map (kbd "C-M-i") 'auto-complete)

;; encoding
(setq slime-net-coding-system 'utf-8-unix)

;; popwin for slime
(push '("*slime-apropos*") popwin:special-display-config)
(push '("*slime-macroexpansion*") popwin:special-display-config)
(push '("*slime-description*") popwin:special-display-config)
(push '("*slime-compilation*" :noselect t) popwin:special-display-config)
(push '("*slime-xref*") popwin:special-display-config)
(push '(sldb-mode :stick t) popwin:special-display-config)
(push '(slime-repl-mode :stick t) popwin:special-display-config)
(push '(slime-connection-list-mode) popwin:special-display-config)

;; for clojure
(setq slime-protocol-version 'ignore)

;; face
(set-face-foreground 'slime-repl-inputed-output-face "pink1")

;;;; ac-slime
;; (auto-install-from-url "https://github.com/purcell/ac-slime/raw/master/ac-slime.el")
(require 'ac-slime)
(progn
  (add-hook 'slime-mode-hook 'set-up-slime-ac)
  (add-hook 'slime-repl-mode-hook 'set-up-slime-ac))

(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))

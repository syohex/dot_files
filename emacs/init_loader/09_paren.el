;; show paren
(show-paren-mode 1)
(setq show-paren-delay 0
      show-paren-style 'expression)
(when window-system
  (set-face-attribute 'show-paren-match-face nil
                      :background nil :foreground nil
                      :underline "#ffff00" :weight 'extra-bold))

;;;; Paredit
(require 'paredit)

(dolist (hook '(emacs-lisp-mode-hook
                lisp-interaction-mode-hook
                lisp-mode-hook
                ielm-mode-hook
                scheme-mode-hook
                inferior-scheme-mode-hook
                clojure-mode-hook
                slime-repl-mode-hook))
  (add-hook hook 'enable-paredit-mode))

(define-key paredit-mode-map (kbd "C-(") 'paredit-forward-barf-sexp)
(define-key paredit-mode-map (kbd "C-)") 'paredit-forward-slurp-sexp)

;;; slime
(require 'slime)

;; SLIME REPL
(slime-setup '(slime-repl slime-fancy slime-banner))

(define-key slime-repl-mode-map (kbd "TAB") nil)

;; encoding
(setq slime-net-coding-system 'utf-8-unix)

;; for clojure
(setq slime-protocol-version 'ignore)

(defun my/slime-mode-hook ()
  (define-key slime-mode-map (kbd "C-M-i") 'auto-complete)
  (define-key slime-mode-map (kbd "C-c C-d C-l") 'helm-hyperspec))
(add-hook 'slime-mode-hook 'my/slime-mode-hook)

;; face
(set-face-foreground 'slime-repl-inputed-output-face "pink1")

;;;; ac-slime
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))

;; setting for emacs-lisp
(find-function-setup-keys)

;;;; eldoc
;; (install-elisp-from-emacswiki "eldoc-extension.el")
(when (require 'eldoc-extension nil t)
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
  (setq eldoc-idle-delay 0.2)
  (setq eldoc-minor-mode-string ""))

;; for regexp color
(set-face-foreground 'font-lock-regexp-grouping-backslash "#ff1493")
(set-face-foreground 'font-lock-regexp-grouping-construct "#ff8c00")

;; for completion
(define-key emacs-lisp-mode-map
  (kbd "M-C-i") 'anything-lisp-complete-symbol-partial-match)
(define-key lisp-interaction-mode-map
  (kbd "M-C-i") 'anything-lisp-complete-symbol-partial-match)

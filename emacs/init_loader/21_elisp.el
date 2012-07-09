;; setting for emacs-lisp
(find-function-setup-keys)

;;;; eldoc
;; (auto-install-from-url-from-emacswiki "eldoc-extension.el")
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
(define-key emacs-lisp-mode-map (kbd "M-C-i") 'auto-complete)
(define-key lisp-interaction-mode-map (kbd "M-C-i") 'auto-complete)

;; ielm
(defun ielm-other-window ()
  "Run ielm on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*ielm*"))
  (call-interactively 'ielm))

(define-key emacs-lisp-mode-map (kbd "C-c C-z") 'ielm-other-window)

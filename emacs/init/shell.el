;; Shell/Command utilities

;; direnv
(add-to-list 'auto-mode-alist '("/\\.envrc\\'" . sh-mode))

;; compilation
(custom-set-variables
 '(compile-command "")
 '(compilation-always-kill t)
 '(compilation-message-face nil)
 '(compilation-auto-jump-to-first-error t))

;; comint
(custom-set-variables
 '(comint-input-ignoredups t))

(defun my/colorize-compilation-buffer ()
  (ansi-color-process-output nil))

(with-eval-after-load 'compile
  (add-hook 'compilation-filter-hook 'my/colorize-compilation-buffer))

;; eshell
(custom-set-variables
 '(eshell-banner-message "")
 '(eshell-cmpl-cycle-completions nil)
 '(eshell-hist-ignoredups t)
 '(eshell-scroll-show-maximum-output nil))

(setq-default eshell-path-env (getenv "PATH"))
(global-set-key (kbd "C-\\") 'eshellutil-popup)

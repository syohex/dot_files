;; Shell/Command utilities

;; sh-mode
(custom-set-variables
 '(sh-indentation 2))

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

(with-eval-after-load 'term-mode
  (define-key term-mode-map (kbd "C-z") elscreen-map)
  (define-key term-raw-map (kbd "C-z") elscreen-map))

;; eshell
(custom-set-variables
 '(eshell-banner-message "")
 '(eshell-cmpl-cycle-completions nil)
 '(eshell-hist-ignoredups t)
 '(eshell-scroll-show-maximum-output nil))

(setq-default eshell-path-env (getenv "PATH"))

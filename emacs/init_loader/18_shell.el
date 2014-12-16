;; shellscript mode
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))

;; compilation
(custom-set-variables
 '(compile-command "")
 '(compilation-always-kill t)
 '(compilation-message-face nil))

;; eshell
(custom-set-variables
 '(eshell-cmpl-cycle-completions nil)
 '(eshell-hist-ignoredups t))

(with-eval-after-load 'shell-pop
  (require 'eshellutil)
  (add-hook 'shell-pop-up-hook 'eshellutil-shell-pop-up-hook))

(defun my/eshell-first-time-load-hook ()
  (define-key eshell-mode-map (kbd "M-r") 'helm-eshell-history)
  (setq eshell-first-time-p nil))
(add-hook 'eshell-first-time-mode-hook 'my/eshell-first-time-load-hook)

(custom-set-variables
 '(shell-pop-autocd-to-working-dir nil)
 '(shell-pop-shell-type '("eshell" " *eshell*" (lambda () (eshell))))
 '(shell-pop-universal-key "C-M-r")
 '(shell-pop-full-span t))
(global-set-key (kbd "C-M-r") 'shell-pop)

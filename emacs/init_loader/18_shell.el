;; shellscript mode
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))

;; compilation
(custom-set-variables
 '(compilation-message-face nil))

(with-eval-after-load 'compile
  (set-face-attribute 'compilation-error nil :underline nil)
  (set-face-attribute 'compilation-line-number nil :underline t))

;; eshell
(with-eval-after-load 'shell-pop
  (require 'eshellutil)
  (add-hook 'shell-pop-up-hook 'eshellutil-shell-pop-up-hook))

(with-eval-after-load 'em-prompt
  (set-face-attribute 'eshell-prompt nil
                      :foreground "yellow"))

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

;;;; GNU gtags
(defun my/helm-gtags-mode-hook ()
  (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
  (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
  (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
  (local-set-key (kbd "M-,") 'helm-gtags-pop-stack))

(add-hook 'helm-gtags-mode-hook 'my/helm-gtags-mode-hook)

;;; Enable helm-gtags-mode
(dolist (hook '(c-mode-common-hook
                c++-mode-hook
                java-mode-hook
                asm-mode-hook))
  (add-hook hook 'helm-gtags-mode))

;; setting for flycheck

(defun my/flycheck-list-errors ()
  (interactive)
  (when (bound-and-true-p flycheck-mode)
    (flycheck-mode +1))
  (call-interactively 'flycheck-list-errors))

(custom-set-variables
 '(flycheck-display-errors-delay 0.5)
 '(flycheck-idle-change-delay 1.0)
 '(flycheck-display-errors-function nil))

(with-eval-after-load 'flycheck
  (define-key flycheck-command-map (kbd "M-g M-n") 'flycheck-next-error)
  (define-key flycheck-command-map (kbd "M-g M-p") 'flycheck-previous-error))

;; use space not use tab
(setq-default indent-tabs-mode nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defvar my/current-cleanup-state "")

(setq-default mode-line-format
              (cons '(:eval my/current-cleanup-state)
                    mode-line-format))

(defun toggle-cleanup-spaces ()
  (interactive)
  (cond ((memq 'my/cleanup-for-spaces before-save-hook)
         (setq my/current-cleanup-state
               (propertize "[DT-]" 'face '((:foreground "turquoise1" :weight bold))))
         (remove-hook 'before-save-hook 'my/cleanup-for-spaces))
        (t
         (setq my/current-cleanup-state "")
         (add-hook 'before-save-hook 'my/cleanup-for-spaces)))
  (force-mode-line-update))

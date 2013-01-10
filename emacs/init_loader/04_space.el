;; use space not use tab
(when window-system
  (setq-default indent-tabs-mode nil))

;; delete trailling space and blank line tail of file
(defun my/delete-trailing-blank-lines ()
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-max))
      (delete-blank-lines))))

(when window-system
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  (add-hook 'before-save-hook 'my/delete-trailing-blank-lines))

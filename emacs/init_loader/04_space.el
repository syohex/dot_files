;; for whitespace-mode
(require 'whitespace)
;; see whitespace.el for more details
(setq whitespace-style '(face tabs tab-mark spaces space-mark))
(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        (tab-mark ?\t [?\xBB ?\t] [?\\ ?\t])))
(setq whitespace-space-regexp "\\(\u3000+\\)")
(set-face-foreground 'whitespace-tab "#adff2f")
(set-face-background 'whitespace-tab 'nil)
(set-face-underline  'whitespace-tab t)
(set-face-foreground 'whitespace-space "#7cfc00")
(set-face-background 'whitespace-space 'nil)
(set-face-bold-p 'whitespace-space t)
(global-set-key (kbd "C-x w") 'global-whitespace-mode)

;; use space not use tab
(if window-system
    (setq-default indent-tabs-mode nil))

(defun toggle-indent-tab-mode ()
  (interactive)
  (if indent-tabs-mode
      (setq-default indent-tabs-mode nil)
    (setq-default indent-tabs-mode t)))

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

;; for toggle delete-trailing-whitespace
(defun toggle-delete-trailing-whitespace-setting ()
  (interactive)
  (dolist (func '(delete-trailing-whitespace my/delete-trailing-blank-lines))
    (cond ((find func before-save-hook)
           (remove-hook 'before-save-hook func))
          (t
           (add-hook 'before-save-hook func)))))

;; org-mode
(when (require 'org-install nil t)
  (define-key global-map (kbd "C-c l") 'org-store-link)
  (setq org-startup-truncated nil)
  (setq org-return-follows-link t)
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (org-remember-insinuate)
  (setq org-directory  (expand-file-name "~/.emacs.d/"))
  (setq org-startup-folded 'nofold)
  (setq org-use-fast-todo-selection t)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "|" "DONE(x)" "CANCEL(c)")
          (sequence "APPT(a)" "|" "DONE(x)" "CANCEL(c)")))
  (setq org-todo-keyword-faces
        '(("TODO"      . org-warning)
          ("STARTED"   . (:foreground "deep sky blue" :weight bold))
          ("DONE"      . (:foreground "SpringGreen1" :weight bold))
          ("WAITING"   . (:foreground "orange" :weight bold))))

  ;; faces
  (set-face-foreground 'org-block "green")
  (set-face-foreground 'org-tag "green yellow")

  ;; function of org-open-at-point
  (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file)

  ;; hooks
  (add-hook 'org-mode-hook 'my/org-mode-hook))

(defun my/org-mode-hook ()
  (interactive)
  (local-set-key (kbd "C-t") 'org-mark-ring-goto)
  (local-set-key (kbd "C-M-<return>") 'org-insert-todo-heading)
  (local-unset-key (kbd "M-S-<return>")))

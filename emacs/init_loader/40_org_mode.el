;; org-mode
(eval-after-load "org"
  '(progn
     (require 'org-install)

     (define-key global-map (kbd "C-c l") 'org-store-link)
     (setq org-startup-truncated nil
           org-return-follows-link t
           org-directory user-emacs-directory
           org-use-fast-todo-selection t)

     (setq org-todo-keywords '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "|" "DONE(x)" "CANCEL(c)")
                               (sequence "APPT(a)" "|" "DONE(x)" "CANCEL(c)")))
     (setq org-todo-keyword-faces
           '(("TODO"      . org-warning)
             ("STARTED"   . (:foreground "deep sky blue" :weight bold))
             ("DONE"      . (:foreground "SpringGreen1" :weight bold))
             ("WAITING"   . (:foreground "orange" :weight bold))))

     ;; faces
     (require 'org-faces)
     (set-face-foreground 'org-block "green")
     (set-face-foreground 'org-tag "green yellow")

     ;; function of org-open-at-point
     (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file)

     (define-key org-mode-map (kbd "C-t") 'org-mark-ring-goto)
     (define-key org-mode-map (kbd "C-c t") 'org-toggle-link-display)
     (define-key org-mode-map (kbd "C-M-<return>") 'org-insert-todo-heading)
     (define-key org-mode-map (kbd "C-c C-i") 'my/org-insert-pomodoro-template)
     (define-key org-mode-map (kbd "C-M-<tab>") 'show-all)
     (local-unset-key (kbd "M-S-<return>"))

     (smartrep-define-key
         org-mode-map "C-c" '(("f" . 'org-shiftright)
                              ("b" . 'org-shiftleft)))
     (smartrep-define-key
         org-mode-map "C-c" '(("C-n" . (outline-next-visible-heading 1))
                              ("C-p" . (outline-previous-visible-heading 1))))))

(defun my/org-insert-pomodoro-template ()
  (interactive)
  (let ((date-str (format-time-string "<%Y-%m-%d %a>" (current-time))))
    (insert (format "** %s [/]\n   - " date-str))))
